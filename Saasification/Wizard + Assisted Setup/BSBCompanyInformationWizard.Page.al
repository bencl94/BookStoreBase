page 50130 "BSB_Company Information Wizard"
{
    Caption = 'Setup Company Information';
    PageType = NavigatePage;
    SourceTable = "Company Information";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and not FinishActionEnabled;
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Media Reference field.';
                }
            }
            group(FinishedBanner)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and FinishActionEnabled;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Media Reference field.';
                }
            }

            group(Step1)
            {
                Visible = Step1Visible;
                group("Company Name")
                {
                    Caption = 'Company Name';
                    Visible = Step1Visible;
                    InstructionalText = 'Provide the name of your company';

                    field(Name; Rec.Name)
                    {
                        Caption = 'Name';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Name field.';
                    }
                }
            }

            group(Step2)
            {
                Caption = 'E-Mail Address';
                Visible = Step2Visible;
                group("Company E-Mail")
                {
                    Caption = 'E-Mail Address';
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the E-Mail field.';
                    }
                }
            }


            group(Step3)
            {
                Visible = Step3Visible;
                group(Group23)
                {
                    Caption = 'All Done';
                    InstructionalText = 'Thank you! To save this setup, choose Finish.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Back';
                Enabled = BackActionEnabled;
                Image = PreviousRecord;
                InFooterBar = true;
                ToolTip = 'Executes the Back action.';
                trigger OnAction();
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
                Caption = 'Next';
                Enabled = NextActionEnabled;
                Image = NextRecord;
                InFooterBar = true;
                ToolTip = 'Executes the Next action.';
                trigger OnAction();
                begin
                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Finish';
                Enabled = FinishActionEnabled;
                Image = Approve;
                InFooterBar = true;
                ToolTip = 'Executes the Finish action.';
                trigger OnAction();
                begin
                    FinishAction();
                end;
            }
        }
    }
    trigger OnInit();
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage();
    var
#pragma warning disable AA0072
        CompanyInfo: Record "Company Information";
#pragma warning restore AA0072
    begin
        Rec.Init();
        if CompanyInfo.Get() then
            Rec.TransferFields(CompanyInfo);

        Rec.Insert();

        Step := Step::Start;
        EnableControls();
    end;

    var
        MediaRepositoryDone: Record "Media Repository";
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";
        MediaResourcesStandard: Record "Media Resources";
        Step: Option Start,Step2,Finish;
        BackActionEnabled: Boolean;
        FinishActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        Step1Visible: Boolean;
        Step2Visible: Boolean;
        Step3Visible: Boolean;
        TopBannerVisible: Boolean;

    local procedure EnableControls();
    begin
        ResetControls();

        case Step of
            Step::Start:
                ShowStep1();
            Step::Step2:
                ShowStep2();
            Step::Finish:
                ShowStep3();
        end;
    end;

    local procedure StoreCompanyInfo();
    var
#pragma warning disable AA0072
        CompanyInfo: Record "Company Information";
#pragma warning restore AA0072
    begin
        if not CompanyInfo.Get() then begin
            CompanyInfo.Init();
            CompanyInfo.Insert();
        end;

        CompanyInfo.TransferFields(Rec, false);
        CompanyInfo.Modify(true);
    end;


    local procedure FinishAction();
    begin
        StoreCompanyInfo();
        CurrPage.Close();
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        ELSE
            Step := Step + 1;

        EnableControls();
    end;

    local procedure ShowStep1();
    begin
        Step1Visible := true;

        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;

    local procedure ShowStep2();
    begin
        Step2Visible := true;
    end;

    local procedure ShowStep3();
    begin
        Step3Visible := true;

        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;

    local procedure ResetControls();
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;

        Step1Visible := false;
        Step2Visible := false;
        Step3Visible := false;
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.GET('AssistedSetup-NoText-400px.png', FORMAT(CurrentClientType())) AND
           MediaRepositoryDone.GET('AssistedSetupDone-NoText-400px.png', FORMAT(CurrentClientType()))
        then
            if MediaResourcesStandard.GET(MediaRepositoryStandard."Media Resources Ref") AND
               MediaResourcesDone.GET(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();
    end;
}