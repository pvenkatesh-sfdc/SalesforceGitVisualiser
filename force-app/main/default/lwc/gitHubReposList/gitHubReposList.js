import { LightningElement, wire } from 'lwc';
import fetchGitHubRepos from '@salesforce/apex/GitHubRepoController.fetchGitHubRepos';

const columns = [
     {label: 'Repo name', fieldName: 'Name__c', type: 'text'},
     {label: 'Repo Description', fieldName: 'Description__c', type: 'text'},
];

export default class GitHubReposList extends LightningElement {

    error;
    columns = columns;
    @wire(fetchGitHubRepos) gitHubRepos;
}