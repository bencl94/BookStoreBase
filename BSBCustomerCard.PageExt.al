pageextension 50100 "BSB_Customer Card" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group("BSB_Bookstore")
            {
                Caption = 'Bookstore';

                field("BSB_Favorite Book No."; Rec."BSB_Favorite Book No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Favorite Book No. field.';
                }
                field("BSB_Favorite Book Description"; Rec."BSB_Favorite Book Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Favorite Book Description field.';
                }
            }
        }
        addafter(Control149)
        {
            part(BSBBookFactbox; "BSB_Book Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("BSB_Favorite Book No.");
            }
            part(BingMapsCardPart; "BSB_BingMapsCardPart")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
}