table 50101 "BSB_Internal Log"
{
    Caption = 'Internal Log';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Company; Text[50])
        {
            Caption = 'Company';
            DataClassification = ToBeClassified;
        }
        field(4; Created; DateTime)
        {
            Caption = 'Created';
            DataClassification = ToBeClassified;
        }
        field(5; Comment; Text[500])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure InsertNewLog(TriggerTxt: Text)
    var
        BSBInternalLog: Record "BSB_Internal Log";
        ExecContext: ExecutionContext;
        ModuleInfo: ModuleInfo;
    begin
        BSBInternalLog.Init();
        BSBInternalLog.Description := CopyStr(TriggerTxt, 1, MaxStrLen(BSBInternalLog.Description));
        BSBInternalLog.Created := CurrentDateTime();
        BSBInternalLog.Company := CopyStr(CompanyName(), 1, MaxStrLen(BSBInternalLog.Company));
        ExecContext := Session.GetCurrentModuleExecutionContext();
#pragma warning disable AA0217
        BSBInternalLog.Comment := StrSubstNo('%1', ExecContext);
#pragma warning restore AA0217
        NavApp.GetCurrentModuleInfo(ModuleInfo);
#pragma warning disable AA0217
        BSBInternalLog.Comment += StrSubstNo(' - AppName: %1 - AppVersion:%2 - DataVersion:%3', ModuleInfo.Name, ModuleInfo.AppVersion, ModuleInfo.DataVersion);
#pragma warning restore AA0217
        BSBInternalLog.Insert();
    end;


}
