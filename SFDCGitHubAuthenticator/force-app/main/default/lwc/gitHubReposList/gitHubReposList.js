import { LightningElement, wire } from 'lwc';
import fetchGitHubRepos from '@salesforce/apex/GitHubRepoController.fetchGitHubRepos';

const columns = [
     {label: 'Repo name', fieldName: 'name__c', type: 'text'},
     {label: 'Repo Description', fieldName: 'description__c', type: 'text'},
];

export default class GitHubReposList extends LightningElement {

    error;
    columns = columns;

     @wire(fetchGitHubRepos)
    gitHubRepos;
}