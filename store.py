#!/usr/bin/env python3

from app import con, cur

# STORE related functions
def store_add():
    try:
        store = {}
        store["no"] = int(input("Store number: "))
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
        store = {}
        store["no"] = int(input("Store number of store you want to edit: "))
        while ( 1 ):
            print("What attribute do you want to edit?")
            print("1. Store Number")
            print("2. Location")
            ops = int(input("Your choice> "))
            query = ""
            if ops == 1:
                inp = int(input("Updated store number: "))
                query = f"update STORE set StoreNo={inp} where StoreNo={store['no']};"
                break
            elif ops == 2:
                inp = input("Updated location: ")
                query = f"update STORE set Location={inp} where StoreNo={store['no']};"
                break
            else:
                print("Invalid input. Please try again")
            cur.execute(query)
            con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to update")
        print(">>>", e)
    return

def store_delete():
    try:
        store_no = int(input("Store number of store you want to delete: "))
        query = f"delete from STORE where StoreNo={store_no};"
        cur.execute(query)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to delete")
        print(">>>", e)

def choice_store ():
    while ( 1 ):
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
