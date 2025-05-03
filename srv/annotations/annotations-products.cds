using {ServicioProductos as service} from '../service';
using from './annotations-suppliers';
using from './annotations-product-details';

annotate service.Products with {

    product      @title: 'Product';
    productName  @title: 'Product Name';
    category     @title: 'Category';
    subCategory  @title: 'SubCategory';
    availability @title: 'Availability';
    supplier     @title: 'Supplier';
    rating       @title: 'Rating';
    price        @title: 'Price' @Measures.ISOCurrency: currency;
    currency @Common.IsCurrency: true;

}


annotate service.Products with {


    availability @Common : { 
        Text : availability.name,
        TextArrangement : #TextOnly,
     };

     category @Common : { 
        Text : category.category,
        TextArrangement : #TextOnly,
        ValueListWithFixedValues,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'VH_Categories',
            Parameters: [
               {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : category_ID,
                ValueListProperty : 'ID'
               }
            ]
        },
     };

     subCategory @Common : { 
        Text : subCategory.subCategory,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'VH_SubCategories',
            Parameters: [
               {
                $Type : 'Common.ValueListParameterIn',
                LocalDataProperty : category_ID,
                ValueListProperty : 'category_ID'
               },
               {
                 $Type : 'Common.ValueListParameterOut',
                 LocalDataProperty : subCategory_ID,
                ValueListProperty : 'ID'   
               }
            ]
        },
     };

     supplier @Common : { 
        Text : supplier.supplierName,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Suppliers',
            Parameters: [
               {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : supplier_ID,
                ValueListProperty : 'ID'
               }
            ]
        },
     }
}


annotate service.Products with @(


// Capabilities.FilterRestrictions #Filter: {
//     $Type : 'Capabilities.FilterRestrictionsType',
//     FilterExpressionRestrictions : [
//         {
//             $Type : 'Capabilities.FilterRestrictionsType',
//             AllowedExpressions: 'SearchExpression'

//         }
//     ]
// },


UI.SelectionFields : [
    product,
    supplier_ID,
    category_ID,
    subCategory_ID,
    availability_code
],



UI.HeaderInfo :{
    $Type :'UI.HeaderInfoType',
    TypeName : 'Product',
    TypeNamePlural : 'Products',
    Title : {
        $Type : 'UI.DataField',
        Value : productName
    },
    Description : {
        $Type : 'UI.DataField',
        Value : product
    },
},

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
        Criticality: availability.criticality,
        ![@HTML5.CssDefaults] : {
            $Type : 'HTML5.CssDefaultsType',
            width : '10rem'
        },
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
    },

    UI.FieldGroup #HeaderA :{
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : supplier_ID
            },
            {
                $Type : 'UI.DataField',
                Value : category_ID
            },
            {
                $Type : 'UI.DataField',
                Value : subCategory_ID
            },
        ]
    },

    UI.FieldGroup #ProductDescription :{
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : description
            },
        ]
    },

    UI.FieldGroup #Availability :{
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : availability_code,
                Criticality : availability.criticality,
                Label : ''
            },
        ]
    },

    UI.FieldGroup #Price :{
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : price,
                Label : ''
            },
        ]
    },

    UI.HeaderFacets : [

        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#HeaderA',
            ID : 'HeaderA'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#ProductDescription',
            ID : 'ProductDescription',
            Label : 'Product Description'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Availability',
            ID : 'ProductAvailability',
            Label : 'Availability'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Price',
            ID : 'Price',
            Label : 'Price'
        }
    ],

    UI.Facets : [

        {
            $Type : 'UI.CollectionFacet',
            Facets : [

                {
                    $Type : 'UI.ReferenceFacet',
                    Target : 'supplier/@UI.FieldGroup#Supplier',
                    Label : 'Information'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Target : 'supplier/contact/@UI.FieldGroup#Contact',
                    Label : 'Contact Person'
                }
            ],
            Label : 'Supplier Information' 
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'detail/@UI.FieldGroup#ProductDetail',
            Label : 'Product Information'
        }
        
    ]

    
);
