using {ServicioProductos as service} from '../service';

annotate service.Contacts with {
    fullName     @title : 'Full Name' @Common.FieldControl: #ReadOnly;
    eMail        @title : 'eMail' @Common.FieldControl: #ReadOnly;
    phoneNumber  @title : 'Phone Number'@Common.FieldControl: #ReadOnly;


};

annotate service.Contacts with @(

UI.FieldGroup #Contact: {
    $Type: 'UI.FieldGroupType',
    Data : [
        {
            $Type: 'UI.DataField',
            Value: fullName
        },
        {
            $Type: 'UI.DataField',
            Value: eMail
        },
        {
            $Type: 'UI.DataField',
            Value: phoneNumber
        },
    ]
});
