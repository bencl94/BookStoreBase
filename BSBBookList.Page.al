page 50101 "BSB_Book List"
{

    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Books';
    PageType = List;
    SourceTable = BSB_Book;
    Editable = false;
    CardPageId = "BSB_Book Card";
    ShowFilter = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Nr. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Beschreibung field.';
                    ApplicationArea = All;
                }
                field(ISBN; Rec.ISBN)
                {
                    ToolTip = 'Specifies the value of the ISBN field.';
                    ApplicationArea = All;
                }
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the value of the Autor field.';
                    ApplicationArea = All;
                }
                field("No. of Pages"; Rec."No. of Pages")
                {
                    ToolTip = 'Specifies the number of pages.';
                    ApplicationArea = All;
                    Visible = false;
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
    actions
    {
        area(Processing)
        {
            action(CreateBooks)
            {
                ApplicationArea = All;
                Caption = 'Create Books', comment = 'DEU="Bücher erstellen"';
                Image = CreateDocuments;
                RunObject = codeunit "BSB_Create Books";
                ToolTip = 'Executes the Create Books action.';
            }

            action(Evaluation)
            {
                Caption = 'Evaluation';
                ApplicationArea = All;
                Image = Evaluate;
                ToolTip = 'Executes the Evaluate action';

                trigger OnAction()
                var
                    BSB_BookTypeMgt: Codeunit "BSB_Book Type Mgt.";
                    BSB_BookTypeEvaluation: Interface "BSB_Book Type Evaluation";
                begin
                    BSB_BookTypeMgt.GetHandler(Rec, BSB_BookTypeEvaluation);
                    BSB_BookTypeEvaluation.GetEvaluation();
                end;
            }
        }
    }


}
