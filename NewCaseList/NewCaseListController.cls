public class NewCaseListController {
    public List<Case> getNewCases() {
        List<Case> cases = [SELECT Id, CaseNumber from Case WHERE Status='New' ];
        return cases;
    }
}   
    