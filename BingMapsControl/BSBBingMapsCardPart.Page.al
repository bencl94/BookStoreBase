page 50120 "BSB_BingMapsCardPart"
{
    Caption = 'Map';
    PageType = CardPart;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            usercontrol(BingMaps; "BSB_BingMapsControl")
            {
                ApplicationArea = All;
                trigger ControlAddInReady()
                begin
                    ControlIsReady := true;
                    ShowAddress();
                end;
            }
        }
    }

    var
        ControlIsReady: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        ShowAddress();
    end;

    local procedure ShowAddress()
    var
        CustAddress: Text;
    begin
        if not ControlIsReady then
            exit;

        CustAddress := Rec.Address;

        if Rec.City <> '' then
            CustAddress += ', ' + Rec.City;

        if Rec.County <> '' then
            CustAddress += ', ' + Rec.County;

        if Rec."Post Code" <> '' then
            CustAddress += ', ' + Rec."Post Code";

        if Rec."Country/Region Code" <> '' then
            CustAddress += ', ' + Rec."Country/Region Code";

        CurrPage.BingMaps.ShowAddress(CustAddress);
    end;

}