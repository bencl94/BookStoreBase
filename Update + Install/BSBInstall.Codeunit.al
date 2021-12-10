codeunit 50133 "BSB_Install"
{
    Subtype = Install;

    var
        BSBInternalLog: Record "BSB_Internal Log";

    trigger OnInstallAppPerCompany()
    begin
        BSBInternalLog.InsertNewLog('OnInstallAppPerCompany');
        //Code for company related operations

    end;

    trigger OnInstallAppPerDatabase()
    begin
        BSBInternalLog.InsertNewLog('OnInstallAppPerDatabase');
        // Code for database related operations
    end;
}