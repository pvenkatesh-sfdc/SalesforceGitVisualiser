public with sharing class GitHubRepoController {
    @AuraEnabled(cacheable=true)
    public static List<GitHub_Repos__x> fetchGitHubRepos() {
        
        List<GitHub_Repos__x> repoList = [SELECT Id, Name__c, Description__c from GitHub_Repos__x LIMIT 10];
        
        return repoList;
    }
}
