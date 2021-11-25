pagecustomization "BSB_Customer Card" customizes "Customer Card"
{
    layout
    {
        modify("Location Code")
        {
            Visible = False;
        }
    }
    actions
    {
        movebefore(NewSalesInvoice; NewSalesOrder)
    }
}