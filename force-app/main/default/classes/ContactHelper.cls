public with sharing class ContactHelper {
    public ContactHelper() {

    }
    public static void verifyProvidedEmail(List<Contact> contacts){
        String emailRegex = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$';
        Pattern pattern = Pattern.compile(emailRegex);
        Boolean isValid = false;
        Boolean belongsToDomain = false;
        for(Contact contact : contacts){
            Matcher matcher = pattern.matcher(contact.Email);
            isValid = matcher.matches();
            if(isValid){
                belongsToDomain = verifyEmailDomainIsCorrect(contact.Email);
                if(!belongsToDomain){
                    contact.addError('Introduced email does not belong to the v2sa or gmail domain');
                }
            }
            else{
                contact.addError('Introduced email does not fit email format');
            }
        }
    }
    public static Boolean verifyEmailDomainIsCorrect(String email){
        Boolean belongsToDomain = false;
        List<String> targetDomains = new List<String>{'v2sa.com', 'gmail.com'};
        String emailDomain = email.substring(email.indexOf('@')+1);
        for(String targetDomain : targetDomains){
            if(emailDomain.toLowerCase() == targetDomain.toLowerCase()){
                belongsToDomain = true;
                break;
            }else {
                belongsToDomain = false;
            }
        }
        return belongsToDomain;
    }
}