public with sharing class GitHubRepoController {
    @AuraEnabled(cacheable=true)
    public static List<GitHub_Repos__x> fetchGitHubRepos() {
        
        List<GitHub_Repos__x> repoList = [
            SELECT Id, 
            Name__c,
            Description__c,
            CreatedDate__c,
            UpdatedDate__c,
            Language__c,
            OpenIssuesCount__c,
            Private__c,
            TotalForks__c,
            Stars__c,
            Size__c
               from GitHub_Repos__x 
               ORDER BY UpdatedDate__c DESC
                LIMIT 10];
        
        return repoList;
    }
}
