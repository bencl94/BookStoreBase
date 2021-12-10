codeunit 50149 "BSB_Create Books"
{
    trigger OnRun()
    var
        Cnt: Integer;
    begin
        for Cnt := 1 to 100 do CreateBook(Cnt);
    end;

    var
#pragma warning disable AA0072
        Book: Record BSB_Book;
#pragma warning restore AA0072

    local procedure CreateBook(Int: Integer)
    var
        Suffix: Text;
    begin
        Book.Init();
        Suffix := format(int);
        if not Book.Get('B' + Suffix) then Book."No." := 'B' + Suffix;
        Book.Validate(Description, 'Buch ' + Suffix);
        Book.Author := 'Autor ' + Suffix;
        Book.ISBN := CopyStr(Suffix, 1, MaxStrLen(Book.ISBN));
        Book."No. of Pages" := Int * 10;
#pragma warning disable AL0603
        Book.Type := int mod 3;
#pragma warning restore AL0603
        Book."Date of Publishing" := Today() + Int;
        if not Book.insert(true) then Book.Modify(true);
    end;
}
