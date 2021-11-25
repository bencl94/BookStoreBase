tableextension 50100 "BSB_Customer" extends Customer
{
    fields
    {
        field(50100; "BSB_Favorite Book No."; Code[20])
        {
            Caption = 'Favorite Book No.';
            DataClassification = ToBeClassified;
            TableRelation = BSB_Book;
        }
        field(50101; "BSB_Favorite Book Description"; Text[100])
        {
            Caption = 'Favorite Book Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(BSB_Book.Description where("No." = field("BSB_Favorite Book No.")));
        }

    }

    // TODO Auswahl gesperrter Bücher soll unterbunden werden
}
