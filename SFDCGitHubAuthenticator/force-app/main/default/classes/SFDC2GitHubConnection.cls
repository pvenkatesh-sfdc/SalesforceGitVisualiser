/**
 * This is the class corresponding to the actual GitHub API calls, the most important of which is query().
 */
global class SFDC2GitHubConnection extends DataSource.Connection {
     
    override global List<DataSource.Table> sync() {
        List<DataSource.Table> tables = new List<DataSource.Table>();
        tables.add(buildRepositoryTable());
        return tables;
    }

    private DataSource.Table buildRepositoryTable(){
        List<DataSource.Column> gitHubRepoColumns = new List<DataSource.Column>();
        gitHubRepoColumns.add(DataSource.Column.text('ExternalId', 255));
        gitHubRepoColumns.add(DataSource.Column.url('DisplayUrl'));
        gitHubRepoColumns.add(DataSource.Column.text('Name', 128));
        gitHubRepoColumns.add(DataSource.Column.text('Description', 1024));
        gitHubRepoColumns.add(DataSource.Column.number('Stars', 16, 0));
        return DataSource.Table.get('GitHub Repos', 'Name', gitHubRepoColumns);
    }


    private List<Map<String, Object>> getRepositories(HttpResponse response){
        List<Map<String, Object>> repositories = new List<Map<String, Object>>();
        for (Object item : (List<Object>)JSON.deserializeUntyped(response.getBody())) {
            repositories.add(buildRepositoryFromJson(item));
        }
        return repositories;
    }


    private Map<String, Object> buildRepositoryFromJson(Object item){
        Map<String, Object> repo = (Map<String, Object>)item;
        repo.put('ExternalId', repo.get('id'));
        repo.put('DisplayUrl', repo.get('html_url'));
        repo.put('Name', repo.get('name'));
        repo.put('Description', repo.get('description'));
        repo.put('Stars', repo.get('stargazers_count'));
        return repo;
    }
        
    override global DataSource.TableResult query(DataSource.QueryContext queryContext) {
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        String org = 'CovidBackToWork';
        String url = 'orgs/' + org + '/repos?per_page=1000';
        request.setEndpoint('callout:GitHub/' + url);
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);

        try {
            // Note: If a 4xx status code occurs when querying the GitHub API, deserializeUntyped()
            // will simply return a Map<Objects> instead of a List<Map<String, Object>>, resulting in
            // a runtime error.
            List<Map<String, Object>> repositories = getRepositories(response);
            List<Map<String, Object>> repos = DataSource.QueryUtils.process(queryContext,repositories );
            DataSource.TableResult tableResult = DataSource.TableResult.get(queryContext, repos);
            
            return tableResult;
        
        } catch (Exception e) {
            throw new IllegalArgumentException('Bad response. Response: ' + response.getBody()
            + ', Status = ' + response.getStatus()
            + ', Status code = ' + response.getStatusCode()
            + ', Request: ' + request.getEndpoint(), e);
        }       
    }
        
    override global List<DataSource.TableResult> search(DataSource.SearchContext searchContext) {
        return DataSource.SearchUtils.searchByName(searchContext, this);
    }
}
