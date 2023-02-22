@isTest
public class ClickHandlerTest {
  public static PageReference getRedirectPage() {
    String baseURL = Utils.getOrgSalesforceSiteBase();
    PageReference returnRef = new PageReference(baseURL + '/click');
    return returnRef;
  }

  //Specify all paths here
  public static List<String> getPaths() {
    return new List<String>{ 'testPath', 'testContactUpdate' };
  }

  public static PageReference getFullPageReference(String pathID) {
    PageReference pageRef = getRedirectPage();
    pageRef.getParameters().put('path', pathID);

    //Add path specific URL parameters
    if (pathID == 'testContactUpdate') {
      Contact mockContact = new Contact(
        FirstName = 'John',
        LastName = 'Smith',
        email = 'test@test.com'
      );
      insert mockContact;
      pageRef.getParameters().put('id', mockContact.Id);
    }

    return pageRef;
  }

  @isTest
  static void testPaths1() {
    List<String> paths = getPaths();
    test.startTest();

    for (Integer i = 0; i < paths.size(); i++) {
      PageReference initialPageRef = getFullPageReference(paths[i]);
        System.debug(initialPageRef);
      Test.setCurrentPage(initialPageRef);
      ClickHandler controller = new ClickHandler();
      PageReference returnPageReference = controller.evaluate();
      System.assertNotEquals(null, returnPageReference);
    }
    Test.StopTest();
  }
}