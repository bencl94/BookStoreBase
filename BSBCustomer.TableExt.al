tableextension 50100 "BSB_Customer" extends Customer
{
    fields
    {
        field(50100; "BSB_Favorite Book No."; Code[20])
        {
            Caption = 'Favorite Book No.';
            DataClassification = ToBeClassified;
            TableRelation = BSB_Book;

            trigger OnValidate()
            begin
                if ("BSB_Favorite Book No." <> '') and
                    ("BSB_Favorite Book No." <> xrec."BSB_Favorite Book No.") then begin
                    BSB_Book.Get("BSB_Favorite Book No.");
                    BSB_Book.TestBlocked();
                end;

                CalcFields("BSB_Favorite Book Description");
            end;
        }
        field(50101; "BSB_Favorite Book Description"; Text[100])
        {
            Caption = 'Favorite Book Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(BSB_Book.Description where("No." = field("BSB_Favorite Book No.")));
        }

    }
    var
        BSB_Book: Record BSB_Book;
}
