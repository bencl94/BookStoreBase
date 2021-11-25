table 50100 "BSB_Book"
{
    Caption = 'Buch';
    DataClassification = ToBeClassified;
    DataCaptionFields = "No.", Description;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Nr.';
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Beschreibung';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Suchbegriff';
            DataClassification = ToBeClassified;
        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Gesperrt';
            DataClassification = ToBeClassified;
        }
        field(5; Type; Option)
        {
            OptionMembers = " ",Hardcover,Paperback;
            OptionCaption = ' ,Hardcover,Paperback';
            DataClassification = ToBeClassified;
        }
        field(7; Created; Date)
        {
            Caption = 'Erstellt am';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(8; "Last Date Modified"; Date)
        {
            caption = 'Letzte Änderung am';
            Editable = False;
            DataClassification = ToBeClassified;
        }
        field(10; Author; Text[50])
        {
            Caption = 'Autor';
            DataClassification = ToBeClassified;
        }
        field(11; "Author Provision %"; Decimal)
        {
            Caption = 'Autor Provision %';
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
            caption = 'Seitenzahl';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(17; "Edition No."; Integer)
        {
            Caption = 'Ausgabenr.';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(18; "Date of Publishing"; Date)
        {
            Caption = 'Datum Veröffentlichung';
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
    begin
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
}