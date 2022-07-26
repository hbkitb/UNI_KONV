xmlport 70038 "Multi C5 CustomerContact"
{

    Direction = Import;
    FieldDelimiter = '¤';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Debitorkontakter)
        {
            tableelement(Contact; Contact)
            {
                XmlName = 'CustContact';
                textelement(CustomerQty)
                {
                }
                /*
                fieldelement(ContNo; Contact."No.")
                {
                    trigger OnBeforePassField()
                    begin
                        Message('1');
                        Message(Contact."No.");
                    end;

                    trigger OnAfterAssignField()
                    begin
                        Message('2');
                        Message(Contact."No.");
                    end;

                }
                */
                textelement(CustomerAccount)
                {
                }
                fieldelement(Name; Contact.Name)
                {
                }
                fieldelement(Position; Contact."Job Title")
                {
                }
                fieldelement(Address; Contact.Address)
                {
                }
                fieldelement(Address2; Contact."Address 2")
                {
                }
                fieldelement(City; Contact.City)
                {
                }
                //* 250722
                fieldelement(Phone; Contact."Phone No.")
                {
                }
                //250722  */
                /*
                                textelement(PhoneTxt)
                                {
                                    trigger OnAfterAssignVariable()

                                    var

                                    begin
                                        //Contact."Phone No." := DelChr(PhoneTxt, '=', 'äÄÜüûabcdefghijklmnopqrstuvwxyzæøå@ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ');
                                    End;

                                }
                                */
                fieldelement(Language; Contact."Language Code")
                {
                }
                fieldelement(CountryRegionCode; Contact."Country/Region Code")
                {
                }
                fieldelement(FaxNo; Contact."Fax No.")
                {
                }
                fieldelement(PostCode; Contact."Post Code")
                {
                }
                fieldelement(Email; Contact."E-Mail")
                {
                }

                fieldelement(Type; Contact.Type)
                {
                }
                fieldelement(CompanyName; Contact."Company Name")
                {
                }
                //* 250722
                fieldelement(Phone; Contact."Phone No.")
                {
                }
                //250722 */
                /*
                textelement(PhoneTxt2)
                {
                    trigger OnAfterAssignVariable()

                    var

                    begin
                        //       Contact."Phone No." := DelChr(PhoneTxt2, '=', 'äÄÜüûabcdefghijklmnopqrstuvwxyzæøå@ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ');
                    End;

                }
                */
                //* 250722
                fieldelement(MobilePhoneNo; Contact."Mobile Phone No.")
                {
                }
                //250722  */

                /*
                                textelement(MobilePhoneTxt)
                                {
                                    trigger OnAfterAssignVariable()

                                    var

                                    begin
                                        //Contact."Mobile Phone No." := DelChr(MobilePhoneTxt, '=', 'äÄÜüûabcdefghijklmnopqrstuvwxyzæøå@ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ');
                                    End;

                                }
                                */

                trigger OnBeforeInsertRecord()
                var
                //NoSeriesMgt: Codeunit NoSeriesManagement;
                //ConNo: Code[20];


                begin
                    /*
                    Message('12345');
                    ConNo := '';
                    if Contact."No." = '' then
                        conno := NoSeriesMgt.TryGetNextNo('EMNE', Today);
                    Message(ConNo);
                    if ConNo <> '' then
                        Contact."No." := ConNo;
                        */
                    Contact."Mobile Phone No." := DelChr(Contact."Mobile Phone No.", '=', 'äÄÜüûabcdefghijklmnopqrstuvwxyzæøå@ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ');
                    Contact."Phone No." := DelChr(Contact."Phone No.", '=', 'äÄÜüûabcdefghijklmnopqrstuvwxyzæøå@ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ');
                end;


                trigger OnBeforeModifyRecord()
                begin

                    //Message('7777');
                    ContBusRel.Get;
                    ContBusRel.SetRange(ContBusRel."Link to Table", ContBusRel."Link to Table"::Customer);
                    ContBusRel.SetRange(ContBusRel."No.", CustomerAccount);

                    Contact."Company No." := ContBusRel."Contact No.";
                    //Message('8888');
                    //Commit;
                    //Message('9999');

                end;


            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        ///*
        Clear(ContBusRel);
        Clear(Contact);
        ContBusRel.SetRange(ContBusRel."Link to Table", ContBusRel."Link to Table"::Customer);

        if ContBusRel.FindSet then
            repeat
                Contact.SetRange(Contact."No.", ContBusRel."Contact No.");
                if Contact.FindSet then
                    repeat
                        Contact.Delete;
                    until Contact.Next = 0;
                ContBusRel.Delete;

            until ContBusRel.Next = 0;
        Commit;
        //       */
    end;

    trigger OnPreXmlPort()
    begin
        //Commit;
        //Message('før');
        REPORT.RunModal(5195, false);
        //REPORT.Run(5195, false);
        Commit;  //260722
        //Message('efter');
    end;


    var
        CustTable: Record Customer;
        ContBusRel: Record "Contact Business Relation";
}

