codeunit 50140 "BSB_Get Exchange Rate"
{
    procedure GetExchangeRate(Currency: Record Currency)
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
#pragma warning disable AA0470
        UrlTxt: Label 'http://data.fixer.io/api/latest?access_key=f9b23a52bde207ec2e65de875534b094&base=%1&symbols=%2';
#pragma warning restore AA0470
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        Url: Text;
    begin
        GeneralLedgerSetup.Get();

        Url := StrSubstNo(
            UrlTxt,
            GeneralLedgerSetup.GetCurrencyCode(''),
            Currency.Code);

        if HttpClient.Get(Url, HttpResponseMessage) then begin
            HttpResponseMessage.Content().ReadAs(ResponseText);
            Message(ResponseText);
        end;
    end;
}