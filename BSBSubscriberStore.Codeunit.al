codeunit 50100 "BSB_Subscriber Store"
{
    var
        FavoriteBookHintMsg: Label 'Do not forget to enter %1 in %2 %3', Comment = '"DEU"=Vergessen Sie nicht die %1 in %2 %3 einzutragen';

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', true, true)]
    local procedure FavouriteBookHintCustomerOnAfterInsert(RunTrigger: Boolean; var Rec: Record Customer)
    begin
        if Rec."BSB_Favorite Book No." = '' then
            Message(FavoriteBookHintMsg, rec.FieldCaption("BSB_Favorite Book No."), rec.TableCaption, Rec."No.");
    end;
}