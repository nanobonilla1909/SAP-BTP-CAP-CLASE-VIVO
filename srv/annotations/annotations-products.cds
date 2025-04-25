using {ServicioProductos as service} from '../service';


annotate service.Products with {

    product      @title: 'Product';
    productName  @title: 'Product Name';
    category     @title: 'Category';
    subCategory  @title: 'SubCategory';
    availability @title: 'Availability';
    rating       @title: 'Rating';
    price        @title: 'Price' @Measures.ISOCurrency: currency;
    currency @Common.IsCurrency: true;

}


annotate service.Products with @(

UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: product,
    },
    {
        $Type: 'UI.DataField',
        Value: productName,
    },
    {
        $Type: 'UI.DataField',
        Value: category_ID,
    },
    {
        $Type: 'UI.DataField',
        Value: subCategory_ID,
    },
    {
        $Type: 'UI.DataField',
        Value: availability_code,
    },
    {
        $Type: 'UI.DataFieldForAnnotation',
        Target: '@UI.DataPoint',
        ![@HTML5.CssDefaults] : {
            $Type : 'HTML5.CssDefaultsType',
            width : '10rem',
        },
    },
    {
        $Type: 'UI.DataField',
        Value: price,
    }
],
    UI.DataPoint: {
        $Type :'UI.DataPointType',
        Visualization : #Rating,
        Value:rating
    }

);
