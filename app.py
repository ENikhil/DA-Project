import subprocess as sp
import pymysql
import pymysql.cursors

# STORE related functions
def store_exist(sn):
    query = f"select * from STORE where StoreNo={sn};"
    cur.execute(query)
    con.commit()
    rows = cur.fetchall()
    if (len(rows) == 0):
        raise Exception(f"Store number {sn} does not exist in database. Please enter a valid store number")
    return


def store_add():
    try:
        store = {}
        clear()
        while ( 1 ):
            print("The allowed store numbers are integers greater than 0")
            store["no"] = int(input("Store number: "))
            if store["no"] > 0:
                break
            else:
                print("Invalid store number. Please try again.")
        store["loc"] = input("Store Location: ")
        query = f"insert into STORE values (\"{store['no']}\", \"{store['loc']}\");"
        #print("query: ", query)
        cur.execute(query)
        con.commit()
        print("Inserted into database")
    except Exception as e:
        con.rollback()
        print("Failed to insert")
        print(">>>", e)
    return

def store_update():
    try:
        clear()
        store = {}
        store["no"] = int(input("Store number of the store you want to edit: "))
        store_exist(store["no"])
        while ( 1 ):
            clear()
            print("What attribute do you want to edit?")
            print("1. Store Number")
            print("2. Location")
            ops = int(input("Your choice> "))
            query = ""
            if ops == 1:
                inp = int(input("Updated store number: "))
                query = f"update STORE set StoreNo={inp} where StoreNo={store['no']};"
            elif ops == 2:
                inp = input("Updated location: ")
                query = f"update STORE set Location='{inp}' where StoreNo={store['no']};"
            else:
                print("Invalid input. Please try again")
                continue
            cur.execute(query)
            con.commit()
            break
    except Exception as e:
        con.rollback()
        print("Failed to update")
        print(">>>", e)
    return

def store_delete():
    try:
        clear()
        store_no = int(input("Store number of store you want to delete: "))
        store_exist(store_no)
        query = f"delete from STORE where StoreNo={store_no};"
        cur.execute(query)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to delete")
        print(">>>", e)

def choice_store ():
    while ( 1 ):
        clear()
        print("1. Add a new store")
        print("2. Update existing store information")
        print("3. Delete a store")
        print("4. Cancel")
        ch = int(input("Your choice> "))
        if ch == 1:
            store_add()
        elif ch == 2:
            store_update()
        elif ch == 3:
            store_delete()
        elif ch == 4:
            break
        else:
            print("Invalid choice. Please try again")
    return


# EMPLOYEE related functions
def employee_exist(eid):
    query = f"select * from EMPLOYEE where EmployeeID={eid};"
    cur.execute(query)
    con.commit()
    rows = cur.fetchall()
    if (len(rows) == 0):
        raise Exception(f"Employee ID {eid} does not exist in database. Please enter a valid employee number")
    return


def employee_add():
    try:
        employee = {}
        clear()
        while ( 1 ):
            print("The allowed employee numbers are integers greater than 0")
            employee["id"] = input("Employee ID (10-digit code consisting of characters): ")
            if len(employee["id"]) == 10:
                break
            else:
                print("Invalid Employee ID. Please try again.")
        employee["fname"] = input("First name: ")
        employee["mname"] = input("Middle name: ")
        employee["lname"] = input("Last name: ")
        employee["dob"] = input("Date of birth (YYYY-MM-DD format): ")
        employee["years_worked"] = 2019 - int(employee["dob"].split("-")[0])
        while ( 1 ):
            employee["sex"] = input("Sex (M, F, or O): ")
            if employee["sex"] != "M" and employee["sex"] != "F" and employee["sex"] != "O":
                print("Invalid sex. Please enter again.")
            else:
                break
        employee["sal"] = input("Salary: ")
        employee["mid"] = input("Manager ID (has to already exist in EMPLOYEE): ")
        employee["wat"] = input("Works at (store number): ")
        query = f"insert into EMPLOYEE values ('{employee['id']}', '{employee['fname']}', '{employee['mname']}', \
                '{employee['lname']}', '{employee['dob']}', '{employee['years_worked']}', '{employee['sex']}', \
                '{employee['sal']}', '{employee['mid']}', '{employee['wat']}');"
        cur.execute(query)
        con.commit()
        print("Inserted into database")
    except Exception as e:
        con.rollback()
        print("Failed to insert")
        print(">>>", e)
        input("Press ENTER to continue>")
    return

def employee_update():
    try:
        clear()
        eid = int(input("Employee ID of the employee you want to edit: "))
        employee_exist(eid)
        while ( 1 ):
            clear()
            print("What attribute do you want to edit?")
            print("1. Employee ID")
            print("2. First Name")
            print("3. Middle Name")
            print("4. Last Name")
            print("5. Date of Birth")
            print("6. Sex")
            print("7. Salary")
            print("8. Manager ID")
            print("9. Works at (Store Number)")
            ops = int(input("Your choice> "))
            query = ""
            if ops == 1:
                while ( 1 ):
                    inp = input("Updated Employee ID: ")
                    if len(inp) == 10:
                        break
                    else:
                        print("Invalid Employee ID. Please try again.")
                query = f"update EMPLOYEE set EmployeeID='{inp}' where EmployeeID='{eid}';"
            elif ops == 2:
                inp = input("Updated first name: ")
                query = f"update EMPLOYEE set Fname='{inp}' where EmployeeID='{eid}';"
            elif ops == 3:
                inp = input("Updated middle name: ")
                query = f"update EMPLOYEE set Mname='{inp}' where EmployeeID='{eid}';"
            elif ops == 4:
                inp = input("Updated last name: ")
                query = f"update EMPLOYEE set Lname='{inp}' where EmployeeID='{eid}';"
            elif ops == 5:
                inp = input("Updated DoB: ")
                query = f"update EMPLOYEE set DoB='{inp}' where EmployeeID='{eid}';"
            elif ops == 6:
                inp = input("Updated Sex: ")
                query = f"update EMPLOYEE set Sex='{inp}' where EmployeeID='{eid}';"
            elif ops == 7:
                inp = input("Updated salary: ")
                query = f"update EMPLOYEE set Salary='{inp}' where EmployeeID='{eid}';"
            elif ops == 8:
                inp = input("Updated Manager ID: ")
                query = f"update EMPLOYEE set ManagerID='{inp}' where EmployeeID='{eid}';"
            elif ops == 9:
                inp = input("Updated works at store no: ")
                query = f"update EMPLOYEE set WorksAt='{inp}' where EmployeeID='{eid}';"
            else:
                print("Invalid input. Please try again")
                input("Press ENTER to continue>")
                continue
            print(query)
            cur.execute(query)
            con.commit()
            break
    except Exception as e:
        con.rollback()
        print("Failed to update")
        print(">>>", e)
        input("Press ENTER to continue>")
    return

def employee_delete():
    try:
        clear()
        eid = int(input("Employee ID of employee you want to delete: "))
        employee_exist(eid)
        query = f"delete from EMPLOYEE where EmployeeID={eid};"
        cur.execute(query)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to delete")
        print(">>>", e)
        input("Press ENTER to continue>")

def choice_employee ():
    while ( 1 ):
        clear()
        print("1. Add a new employee")
        print("2. Update existing employee information")
        print("3. Delete an employee")
        print("4. Go back")
        ch = int(input("Your choice> "))
        if ch == 1:
            employee_add()
        elif ch == 2:
            employee_update()
        elif ch == 3:
            employee_delete()
        elif ch == 4:
            break
        else:
            print("Invalid choice. Please try again")
            input("Press ENTER to continue>")
    return

# CUSTOMER related functions
def customer_exist(cid):
    query = f"select * from CUSTOMER where CustomerID='{cid}';"
    cur.execute(query)
    con.commit()
    rows = cur.fetchall()
    if (len(rows) == 0):
        raise Exception(f"Customer with ID {cid} does not exist in the database")
    return

def choice_customer():
    while ( 1 ):
        clear()
        print("What would you like to do?")
        print("1. Add new customer")
        print("2. Update existing customer information")
        print("3. Go back")
        ops = int(input("Your choice> "))
        if ops == 1:
            customer_add()
        elif ops == 2:
            customer_update()
        elif ops == 3:
            break
        else:
            print("Invalid option. Please try again.")
            input("Press ENTER to continue>")
    return

def customer_add():
    try:
        customer = {}
        print("Please enter the customer's information")
        while ( 1 ):
            customer["id"] = input("Customer ID (10-digit code consisting of characters): ")
            if len(customer["id"]) == 10:
                break
            else:
                print("Invalid Customer ID. Please enter again.")
        customer["fname"] = input("First name: ")
        mn = input("Does customer have a middle name (y for yes)?: ")
        if mn == 'y':
            customer["mname"] = input("Middle name: ")
        else:
            customer["mname"] = "NULL"
        customer["lname"] = input("Last name: ")
        customer["tpv"] = int(input("Total purchase value: "))
        customer["vfb"] = input("ID of Employee that verified the customer (has to exist in EMPLOYEE already):  ")
        query = f"insert into CUSTOMER values ('{customer['id']}', '{customer['fname']}', '{customer['mname']}', \
                '{customer['lname']}', '{customer['tpv']}', '{customer['vfb']}'); "
        print("Query = ", query)
        cur.execute(query)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to insert")
        print(">>>", e)
        input("Press ENTER to continue>")


def customer_update():
    try:
        clear()
        cid = int(input("Customer ID of the customer you want to edit: "))
        customer_exist(cid)
        while ( 1 ):
            clear()
            print("What attribute do you want to edit?")
            print("1. First Name")
            print("2. Middle Name")
            print("3. Last Name")
            print("4. Total Purchase Value")
            ops = int(input("Your choice> "))
            query = ""
            if ops == 1:
                inp = input("Updated first name: ")
                query = f"update CUSTOMER set Fname='{inp}' where CustomerID='{cid}';"
            elif ops == 2:
                inp = input("Updated middle name: ")
                query = f"update CUSTOMER set Mname='{inp}' where CustomerID='{cid}';"
            elif ops == 3:
                inp = input("Updated last name: ")
                query = f"update CUSTOMER set Lname='{inp}' where CustomerID='{cid}';"
            elif ops == 4:
                inp = input("Updated total purchase value: ")
                query = f"update CUSTOMER set TotalPurchaseValue='{inp}' where CustomerID='{cid}';"
            else:
                print("Invalid input. Please try again")
                input("Press ENTER to continue>")
                continue
            print(query)
            cur.execute(query)
            con.commit()
            break
    except Exception as e:
        con.rollback()
        print("Failed to update")
        print(">>>", e)
        input("Press ENTER to continue>")
    return


# Overall functions
def choices (ch):
    if ch == 1:
        choice_store()
    elif ch == 2:
        choice_customer()
    elif ch == 3:
        choice_customer()
    else:
        print("Invalid input. Please try again.")
    return

def clear():
    sp.call('clear', shell=True)
    return


# Global
while(1):
    clear()
#    username = input("Username: ")
#    password = input("Password: ")
    username = "anirudh"
    password = "746058"

    try:
        con = pymysql.connect(host='localhost',
                user=username,
                password=password,
                db='GUN_STORE',
                cursorclass=pymysql.cursors.DictCursor)
        clear()

        if(con.open):
            print("Connected")
        else: 
            print("Failed to connect") 
            input("Enter any key to CONTINUE>")

        with con:
            cur = con.cursor()
            while ( 1 ):
                clear()
                print("Which information would you like to access?")
                print("1. Stores")
                print("2. Employees")
                print("3. Customers")
                print("4. Manufacturers")
                print("5. Logout")
                ch = int(input("Enter choice> "))
                clear()

                if ch == 5:
                    break
                else:
                    choices(ch)
                    input("Enter any key to CONTINUE>")

    except:
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
        input("Press ENTER to continue>")
        exit(0)
    
