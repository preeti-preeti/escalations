/**
* Test utility class
*
* @author Patrick Connelly (patrick@deadlypenguin.com)
*/

@IsTest
public class TestUtils {
	/** The number that the identifiers should be incremented by */
	@TestVisible private static Integer STANDARD_INC = 1000000;

	/** The standard base for random numbers for identifiers */
	@TestVisible private static Integer STANDARD_RAND = 10000;

	/** The base number for an account number */
	public static Integer ACCT_COUNT = 9000000;

	/** The number that the account should be incremented by */
	public static Integer ACCT_INC = STANDARD_INC;

	/**
	* Gets a random integer
	*
	* @param base The base (or upper bounds) for the random number
	* @return A random integer between 0 and the base
	*/
	public static Integer getRandomInteger(Integer base) {
		return math.round(math.random() * base);
	}

	/**
	* Gets an account based on the information provided
	*
	* @param accountNumber The account number
	* @param name The account name
	* @return A new account
	*/
	private static Account getAccount(String accountNumber, String name) {
		return new Account(
			Name = name,
			AccountNumber = accountNumber
		);
	}

	/**
	* Gets an account with a unique account number
	*
	* @return A new account
	*/
	public static Account getAccount() {
		Integer randInt = ACCT_COUNT + getRandomInteger(STANDARD_RAND); // Should be smaller than ACCT_INC
		ACCT_COUNT += ACCT_INC;
		return getAccount(String.valueOf(randInt), '_unittest_account: ' + ACCT_COUNT);
	}

	/**
	* Gets a case for a given account
	*
	* @param account The account to pair the case to
	* @return A new Case
	*/
	public static Case getCase(Account account) {
		return new Case(
			AccountId = account.Id
		);
	}

	/**
	* Gets an escalation
	*
	* @return An escalation
	*/
	public static rh_escal__Escalation__c getEscalation() {
		return new rh_escal__Escalation__c(
			rh_escal__Subject__c = '_unittest_subject: ' + getRandomInteger(1000)
		);
	}

	/**
	* Queries an escalation
	*
	* @param escalation The escalation to query
	* @return The queried escalation
	*/
	public static rh_escal__Escalation__c fetchEscalation(rh_escal__Escalation__c escalation) {
		return [
			select rh_escal__PrimaryCase__c
			from rh_escal__Escalation__c
			where Id = :escalation.Id
		];
	}

	/**
	* Gets an escalation case pairing
	*
	* @param escalation The escalation to pair
	* @param kase The case to pair
	* @return The escalation case pairing
	*/
	public static rh_escal__EscalationCase__c getEscalationCase(rh_escal__Escalation__c escalation, Case kase) {
		return new rh_escal__EscalationCase__c(
			rh_escal__Escalation__c = escalation.Id,
			rh_escal__Case__c = kase.Id
		);
	}

	/**
	* Queries an escalation case
	*
	* @param escalationCase The escalation case to query
	* @return The queried escalation case
	*/
	public static rh_escal__EscalationCase__c fetchEscalationCase(rh_escal__EscalationCase__c escalationCase) {
		return [
			select rh_escal__Case__c,
				rh_escal__Escalation__c,
				rh_escal__Primary__c
			from rh_escal__EscalationCase__c
			where Id = :escalationCase.Id
		];
	}
}