////////////////////////////////////////////////////////////////////////////////////
//                                                                                //
//   A unified class performing specific DML operations when folks click URLs     //
//   use result.page for redirects                                                //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////

public without sharing class ClickHandler {
  public Map<string, String> params { get; set; }

  public ClickHandler() {
    params = ApexPages.currentPage().getParameters();
    System.debug('Parameters are: ' + params);
  }

  public PageReference getRedirectPage() {
    String baseURL = Utils.getOrgSalesforceSiteBase();
    PageReference returnRef = new PageReference(baseURL + '/click/result');
    return returnRef;
  }

  public PageReference evaluate() {
    //Set vars
    PageReference redirect = new PageReference('');
    String path = params.get('path');

    //Choose path
    if (path == 'testPath') {
      redirect = testPath();
    }
    if (path == 'testContactUpdate') {
      String contactId = params.get('id');
      redirect = testContactUpdate(contactId);
    }
    //...
    //... add additional paths here

    //Redirect user
    System.debug('Redirecting to ' + redirect);
    redirect.setRedirect(true);
    return redirect;
  }

  public PageReference testPath() {
    PageReference redirect = new PageReference('https://github.com/');
    return redirect;
  }

  public PageReference testContactUpdate(String contactId) {
    Contact contact = [
      SELECT ID, LastName
      FROM Contact
      WHERE Id = :contactId
    ];

    contact.LastName = contact.LastName + '😊'; //Proof of concept, not a good idea in production.
    update contact;

    PageReference redirect = getRedirectPage();
    redirect.getParameters().put('path', 'testContactUpdate');
    redirect.getParameters().put('id', contactId);
    redirect.getParameters().put('lastName', contact.LastName);

    return redirect;
  }
}
