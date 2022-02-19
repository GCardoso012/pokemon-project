public with sharing class PokemonCallout {

    public static void pokemonCallout(Contact contact) {
        Integration__mdt pokemonAPISettings = [SELECT endPoint__c, Method__c FROM Integration__mdt];
        String endPointPokemon = pokemonAPISettings.endPoint__c + contact.FavoritePokemon__c;

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endPointPokemon);
        request.setMethod(pokemonAPISettings.Method__c);

        HttpResponse response = http.send(request);
        String jsonBody = response.getBody();

        if (response.getStatusCode() == 200 && jsonBody != null) {
            PokemonWrapper.PokemonDetailWrapper pokemonDetails = (PokemonWrapper.PokemonDetailWrapper) JSON.deserialize(jsonBody, PokemonWrapper.PokemonDetailWrapper.class);

            for (PokemonWrapper.StatsWrapper statsWrapper :pokemonDetails.stats) {
                system.debug('statsWrapper: ' + statsWrapper);
                
            }
        }
    }
}