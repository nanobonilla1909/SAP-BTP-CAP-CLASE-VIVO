namespace products_clase.db;

using {
    cuid,
    managed,
    sap.common.CodeList,
    sap.common.Currencies
} from '@sap/cds/common';


entity Products : cuid, managed {

    product       : String(8);
    productName   : String(80);
    image         : LargeBinary  @Core.MediaType: imageType @UI.IsImage;
    imageType     : String       @Core.IsMediaType;
    description   : LargeString;
    category      : Association to Categories;
    subCategory   : Association to SubCategories;
    availability  : Association to Status;
    rating        : Decimal(3, 2);
    price         : Decimal(5, 2);
    currency      : Association to Currencies;     // currency_code
    detail        : Composition of  ProductDetails;
    supplier      : Association to Suppliers;
    toReviews     : Association to many Reviews
                        on toReviews.product = $self;
    toInventories : Composition of  many Inventories
                        on toInventories.product = $self;
    toSales       : Association to many Sales
                        on toSales.product = $self;
}


type short_decimal : Decimal(5, 3);

entity ProductDetails : cuid {

    baseUnit   : String default 'EA';
    height     : short_decimal;
    width      : short_decimal;
    depth      : short_decimal;
    weigth     : short_decimal;
    unitVolume : String default 'CM';
    unitWeight : String default 'KG';
}

entity Suppliers : cuid {

    supplier     : String(9);
    supplierName : String(40);
    webAddress   : String(240);
    contact      : Association to Contacts;
}

entity Contacts : cuid {

    fullName    : String(40);
    eMail       : String(80);
    phoneNumber : String(14);
}

entity Reviews : cuid {

    rating     : Decimal(3, 2);
    date       : Date;
    user       : String(20);
    reviewText : LargeString;
    product    : Association to Products;
}

entity Inventories : cuid {

    stockNumber : String(9);
    department  : Association to Departments;
    min         : Integer default 0;
    max         : Integer default 500;
    target      : Integer;
    quantity    : Decimal(4, 3);
    baseUnit    : String default 'EA';
    product     : Association to Products;
}


entity Sales : cuid {

    monthCode     : String(2);
    month         : String(20);
    year          : String(4);
    quantitySales : Integer;
    product       : Association to Products;
}

/** Code Lists */

entity Status : CodeList {
    key code : String(20) enum {
            InStock         = 'In Stock';
            OutOfStock      = 'Out of Stock';
            LowAvailability = 'Low Availability';
        };

        criticality : Integer;
}


/** Value Helps */

entity Categories : cuid {

    category        : String(80);
    toSubCategories : Association to many SubCategories
                          on toSubCategories.category = $self;
}

entity SubCategories : cuid {

    subCategory : String(80);
    category    : Association to Categories; // category_ID
}

entity Departments : cuid {

    name : String(40);
}
