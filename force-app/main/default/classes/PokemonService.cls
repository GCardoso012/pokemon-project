public with sharing class PokemonService {
    
    @AuraEnabled(cacheable=true)
    public static void pokemonCallout(Contact contact){
        PokemonCallout.pokemonCallout(contact);
    }

    @AuraEnabled(cacheable=true)
    public static Contact getContact(String contactId){
        Contact auxContact;

        List<Contact> lstContact = [SELECT ID, FavoritePokemon__c FROM CONTACT WHERE Id =: contactId LIMIT 1];
        
        if(!lstContact.isEmpty()){
            return lstContact[0];
        }
        
        return auxContact;

    }
}
