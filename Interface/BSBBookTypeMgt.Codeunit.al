codeunit 50113 "BSB_Book Type Mgt."
{
    procedure GetHandler(BSBBook: Record BSB_Book; var BookTypeEvaluation: Interface "BSB_Book Type Evaluation")
    begin
        BookTypeEvaluation := BSBBook.Type;
    end;
}