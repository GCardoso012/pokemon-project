import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import FAVORITEPOKEMON_FIELD from "@salesforce/schema/Contact.FavoritePokemon__c";
import getContact from '@salesforce/apex/PokemonService.getContact';
import callApi from '@salesforce/apex/PokemonService.pokemonCallout';

const CAMPOS = [FAVORITEPOKEMON_FIELD];

export default class Pokemon extends LightningElement {
    @api recordId;
    @track contato = {};
    //@track contato = {};

    @wire(getContact, { contactId : '$recordId' })
    contactRecordDetails({ data, error }){
        if(data){
            this.contato = data;
            console.log('this.contato please');
            console.log(this.contato);
            console.log(this.contato.Id);
            callApi({contactRecord: this.contato})
                .then(result => {
                    console.log(result);
                })
                .catch(error => {
                    this.error = error;
                });
        }else if(error){
        }
    }


    /*
    @wire(getRecord, {
        recordId: "$recordId",
        fields: CAMPOS
    })
    wiredContact({data, error}){
        if(data){
            console.log(JSON.stringify(data));
        }
        if(error){
            console.log(error)
        }
    }

    */
}