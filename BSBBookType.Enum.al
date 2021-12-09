enum 50100 "BSB_Book Type" implements "BSB_Book Type Evaluation"
{
    Extensible = true;
    DefaultImplementation = "BSB_Book Type Evaluation" = "BSB_Book Type Default Impl.";

    value(0; " ") { Caption = ' '; }

    value(1; Hardcover)
    {
        Caption = 'Hardcover';
        Implementation = "BSB_Book Type Evaluation" = "BSB_Book Type Hardcover Impl.";
    }

    value(2; Paperback)
    {
        Caption = 'Paperback';
        Implementation = "BSB_Book Type Evaluation" = "BSB_Book Type Paperback Impl.";
    }
}