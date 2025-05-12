const cds = require('@sap/cds');
// require('dotenv').config();

module.exports = class MiClase extends cds.ApplicationService {

    init () {

        const {Products, Inventories, CBusinessPartner, CSuppliers, CCustomer} = this.entities;

        this.before('NEW', Products.drafts, async (req) => {
            req.data.detail??= {
                baseUnit: 'EA',
                width: null,
                height: null,
                depth: null,
                weigth: null,
                unitVolume: 'CM',
                unitWeight: 'KG'
            }
        });

        this.before('NEW', Inventories.drafts, async (req) => {

            let result = await SELECT.one.from(Inventories).columns('max(stockNumber) as max');
            let result2 = await SELECT.one.from(Inventories.drafts).columns('max(stockNumber) as max').where({product_ID: req.data.product_ID});
            
            let max = parseInt(result.max);
            let max2 = parseInt(result2.max);
            let newMax = 0;

            if (isNaN(max2)) {
                newMax = max + 1;
            } else if (max < max2) {
                newMax = max2 + 1;
            } else {
                newMax = max + 1; 
            }

            req.data.stockNumber = newMax.toString();
        });

        return super.init();
    }

}