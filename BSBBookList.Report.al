report 50100 "BSB_Book List"
{
    Caption = 'Book List';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'BSBBookList.rdlc';

    dataset
    {
        dataitem(SingleRowData; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            column(COMPANYNAME; CompanyProperty.DisplayName()) { }
            column(ShowNoOfPages; ShowNoOfPages) { }
        }
        dataitem(BSB_Book; BSB_Book)
        {
            RequestFilterFields = "No.", Author;

            column(No_BSB_Book; "No.") { IncludeCaption = true; }
            column(Description_BSB_Book; Description) { IncludeCaption = true; }
            column(Author_BSB_Book; Author) { IncludeCaption = true; }
            column(NoofPages_BSB_Book; "No. of Pages") { IncludeCaption = true; }
        }
    }
    requestpage
    {
        SaveValues = True;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowNoOfPages; ShowNoOfPages)
                    {
                        ApplicationArea = All;
                        Caption = 'Show No. of Pages';
                        ToolTip = 'Specifies the value of the Show No. of Pages field.';
                    }
                }

            }
        }
    }
    labels
    {
        ReportCaptionLbl = 'Book - List';
        PageCaptionLbl = 'Page {0} of {1}';
    }

    var
        ShowNoOfPages: Boolean;

}