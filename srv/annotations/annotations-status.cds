using {ServicioProductos as service} from '../service';

annotate service.Status with {

    code @title : 'Availability'
    @Common : {
        Text : 'code',
        TextArrangement : #TextOnly,
    }

}