table 50100 "BSB_Book"
{
    Caption = 'Buch';
    DataClassification = ToBeClassified;
    DataCaptionFields = "No.", Description;
    LookupPageId = "BSB_Book List";
    DrillDownPageId = "BSB_Book List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
            DataClassification = ToBeClassified;
        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
        field(5; Type; Enum "BSB_Book Type")
        {
            DataClassification = ToBeClassified;
        }
        field(7; Created; Date)
        {
            Caption = 'Created';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(8; "Last Date Modified"; Date)
        {
            caption = 'Last Date Modified';
            Editable = False;
            DataClassification = ToBeClassified;
        }
        field(10; Author; Text[50])
        {
            Caption = 'Author';
            DataClassification = ToBeClassified;
        }
        field(11; "Author Provision %"; Decimal)
        {
            Caption = 'Author Provision %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
        }
        field(15; ISBN; Code[20])
        {
            caption = 'ISBN';
            DataClassification = ToBeClassified;
        }
        field(16; "No. of Pages"; Integer)
        {
            caption = 'No. of Pages';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(17; "Edition No."; Integer)
        {
            Caption = 'Edition No.';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(18; "Date of Publishing"; Date)
        {
            Caption = 'Date of Publishing';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, Author, "No. of Pages") { }
    }

    var
        OnDeleteErr: Label 'A %1 cannot be deleted!', Comment = '"DEU"=Ein %1 kann nicht gelöscht werden.';

    trigger OnInsert()
    begin
        Created := Today();
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today();
    end;

    trigger OnDelete()
    var
        IsHandled: Boolean;
    begin
        OnBeforeDeleteBook(Rec, IsHandled);
        if IsHandled then
            exit;
        Error(OnDeleteErr, TableCaption);
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today();
    end;

    procedure TestBlocked()
    begin
        TestField(Blocked, false);
    end;

    procedure ShowCard()
    begin
        Page.Run(Page::"BSB_Book Card", Rec);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDeleteBook(Rec: Record BSB_Book; var isHandled: Boolean)
    begin
    end;
}