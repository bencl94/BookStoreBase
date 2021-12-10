pageextension 50140 "BSB_Currencies" extends Currencies
{
    actions
    {
        addafter("Exch. &Rates")
        {
            action("BSB_Get Exchange Rate")
            {
                Caption = 'Get Exchange Rate';
                Image = Web;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Get Exchange Rate action';

                trigger OnAction()
                var
                    GetExchangeRate: Codeunit "BSB_Get Exchange Rate";
                begin
                    GetExchangeRate.GetExchangeRate(Rec);
                end;
            }
        }
    }
}