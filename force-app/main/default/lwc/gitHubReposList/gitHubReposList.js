import { LightningElement, wire } from 'lwc';
import fetchGitHubRepos from '@salesforce/apex/GitHubRepoController.fetchGitHubRepos';

// Table corresponding to the 'GitHub Repos' external object
const columns = [
     {label: 'Repo name', fieldName: 'Name__c', type: 'text'},
     {label: 'Repo Description', fieldName: 'Description__c', type: 'text'},
     {label: 'Created date', fieldName: 'CreatedDate__c', type: 'date'},
     {label: 'Updated date', fieldName: 'UpdatedDate__c', type: 'date'},
     {label: 'Fork', fieldName: 'Fork__c', type: 'picklist'},
     {label: 'Language', fieldName: 'Language__c', type: 'text'},
     {label: 'OpenIssuesCount', fieldName: 'OpenIssuesCount__c', type: 'number'},
     {label: 'Private', fieldName: 'Private__c', type: 'checkbox'},
     {label: 'Total Forks', fieldName: 'TotalForks__c', type: 'number'},
     {label: 'Stars', fieldName: 'Stars__c', type: 'number'},
     {label: 'Size', fieldName: 'Size__c', type: 'text'},
];

export default class GitHubReposList extends LightningElement {

    error;
    columns = columns;
    @wire(fetchGitHubRepos) gitHubRepos;
}