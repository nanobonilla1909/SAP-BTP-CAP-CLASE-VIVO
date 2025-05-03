using {ServicioProductos as service} from '../service';

annotate service.Reviews with {
    rating     @title : 'Rating';
    Date        @title : 'Date';
    reviewText  @title : 'Review Text';


};

annotate service.Reviews with @(


);
