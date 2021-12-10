codeunit 50102 "BSB_Notif. Subscriber Store"
{
    var
        MyNotifications: Record "My Notifications";

        CredLimitNotif: Notification;
        CredLimitNotifIDTxt: Label 'f08508d6-b995-435a-9da2-8512afa38f66', Locked = true;
        CredLimitNotifMsg: Label '%1 %2 of %3 %4 %5 exceeds %6', Comment = '"DEU"=%1 %2 of %3 %4 %5 exceeds %6';

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure CheckCreditLimit(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
        ActionLbl: Label 'Edit Customer', Comment = '"DEU"=Debitor bearbeiten';
    begin
        if Rec."Bill-to Customer No." = '' then
            exit;
        Customer.SetAutoCalcFields("Balance (LCY)");
        Customer.Get(Rec."Bill-to Customer No.");

        if Customer."Credit Limit (LCY)" = 0 then
            exit;

        if (Customer."Balance (LCY)" > Customer."Credit Limit (LCY)") and (MyNotifications.IsEnabledForRecord(CredLimitNotifIDTxt, Database::Customer))
        then begin
            CredLimitNotif.Id := CredLimitNotifIDTxt;
            CredLimitNotif.Scope := CredLimitNotif.Scope::LocalScope;
            CredLimitNotif.Message(
                StrSubstNo(
                    CredLimitNotifMsg,
                    Customer.FieldCaption("Balance (LCY)"),
                    Customer."Balance (LCY)",
                    Customer.TableCaption,
                    Customer."No.",
                    Customer.Name,
                    Customer."Credit Limit (LCY)"
                )
            );
            CredLimitNotif.SetData('CustNo', Customer."No.");
            CredLimitNotif.AddAction(ActionLbl, Codeunit::"BSB_Notif. Subscriber Store", 'OpenCustomerCard');
            CredLimitNotif.Send();
        end;
    end;

    procedure OpenCustomerCard(CredLimitNotif: Notification)
    var
#pragma warning disable AA0072
        Cust: Record Customer;
#pragma warning restore AA0072
    begin
        Cust.Get(CredLimitNotif.GetData('CustNo'));
        Page.Run(Page::"Customer Card", Cust);
    end;

    [EventSubscriber(ObjectType::Page, Page::"My Notifications", 'OnInitializingNotificationWithDefaultState', '', true, true)]
    local procedure OnInitializingNotificationWithDefaultState_P1518();
    var
        CredLimitNotifDescTxt: Label 'Balance of customer is larger than the credit limit';
        CredLimitNotifTxt: Label 'Customer balance exceeds credit limit';
    begin
        MyNotifications.InsertDefaultWithTableNum(
            ReturnNotificationIdFunction(),
            CredLimitNotifTxt,
            CredLimitNotifDescTxt,
            Database::Customer
        );
    end;

    local procedure ReturnNotificationIdFunction(): Guid;
    begin
        exit(CredLimitNotifIDTxt);
    end;

}