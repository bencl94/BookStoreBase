permissionset 50100 "BSB_Book, ALL"
{
    Caption = 'Book Store All';
    Assignable = false; // Standardwert = NICHT zuweisbar

    Permissions =
        tabledata BSB_Book = rimd,
        table BSB_BOOK = x,
        tabledata "BSB_AL Issue" = RIMD;
}