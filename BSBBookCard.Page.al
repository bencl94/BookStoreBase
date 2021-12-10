#pragma warning disable AW0006
page 50100 "BSB_Book Card"
#pragma warning restore AW0006
{
    PageType = Card;
    SourceTable = BSB_Book;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nr. field.';

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Beschreibung field.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suchbegriff field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gesperrt field.';
                }
                field(Author; Rec.Author)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Autor field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(ISBN; Rec.ISBN)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the ISBN field.';

                }
                field(Created; Rec.Created)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the value of the Erstellt am field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the value of the Letzte Änderung am field.';
                }
            }
            group(Invoicing)
            {
                field("Author Provision %"; Rec."Author Provision %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Autor Provision % field.';
                }
            }
            group(Publishing)
            {
                field("Edition No."; Rec."Edition No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ausgabenr. field.';
                }
                field("No. of Pages"; Rec."No. of Pages")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seitenzahl field.';
                }
                field("Date of Publishing"; Rec."Date of Publishing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Datum Veröffentlichung field.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
}