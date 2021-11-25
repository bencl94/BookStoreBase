page 50102 "BSB_Book Factbox"
{
    PageType = CardPart;
    SourceTable = BSB_Book;
    Caption = 'Book Details';

    layout
    {
        area(Content)
        {
            field("Book No."; Rec."No.")
            {
                Caption = 'Book No.';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Book No. field.';
                trigger OnDrillDown()
                begin
                    ShowDetail();
                end;
            }
            field("Book Description"; Rec.Description)
            {
                Caption = 'Book Description';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Book Description field.';
            }
            field("Date of Publishing"; Rec."Date of Publishing")
            {
                Caption = 'Date of Publishing';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Date of Publishing field.';
            }
            field("No. of Pages"; Rec."No. of Pages")
            {
                Caption = 'No. of Pages';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. of Pages field.';
            }
            field(Author; Rec.Author)
            {
                Caption = 'Author';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Author field.';
            }

        }
    }

    local procedure ShowDetail()
    begin
        Rec.ShowCard();
    end;
}