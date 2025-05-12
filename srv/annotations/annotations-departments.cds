using {ServicioProductos as service} from '../service';

annotate service.VH_Departments with {
    ID @title : 'Departments' @Common : { 
        Text : name,
        TextArrangement : #TextOnly
     }
};