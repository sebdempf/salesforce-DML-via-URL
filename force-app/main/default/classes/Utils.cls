public with sharing class Utils {
  //return e.g. 'indigovolunteers' or 'indigovolunteers--sebs.sandbox' depending on whether it's a production or sandbox org
  public static String getOrgMyDomain() {
    Domain domain = [SELECT Domain FROM Domain LIMIT 1];
    ORganization thisOrg = [SELECT IsSandbox FROM Organization];
    String domainBase = String.valueOf(domain.domain).substringBefore('.');

    if (thisOrg.IsSandbox) {
      domainBase += '.sandbox';
    }

    return domainBase;
  }

  public static String getOrgSalesforceSiteBase() {
    String URL =
      'https://' +
      Utils.getOrgMyDomain() +
      '.my.salesforce-sites.com';
    return URL;
  }
}