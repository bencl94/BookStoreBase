codeunit 50149 "BSB_Create Books"
{
    trigger OnRun()
    var
        Cnt: Integer;
    begin
        for Cnt := 1 to 100 do CreateBook(Cnt);
    end;

    var
        Book: Record BSB_Book;

    local procedure CreateBook(Int: Integer)
    var
        Suffix: Text;
    begin
        Book.Init();
        Suffix := format(int);
        if not Book.Get('B' + Suffix) then Book."No." := 'B' + Suffix;
        Book.Validate(Description, 'Buch ' + Suffix);
        Book.Author := 'Autor ' + Suffix;
        Book.ISBN := Suffix;
        Book."No. of Pages" := Int * 10;
        Book.Type := int mod 3;
        Book."Date of Publishing" := Today() + Int;
        if not Book.insert(true) then Book.Modify(true);
    end;
}
