[BACK](../check_documentation.md)

# Non-Class Exception Check
## What is the Intent of the Check?
The “Non-Class Exception” Check is part of the Clean Code Check Repository.

## How does the check work?
It search for non-class-based exceptions such as:
* `RAISE SYSTEM-EXCEPTIONS`
* `RAISE` ( without `EXCEPTION` or `RESUMABLE EXCEPTION` )
* `MESSAGE with RAISING`

## Which attributes can be maintained?
![Attributes](./img/non_class_based_exception.png)

## How to solve the issue?
Use class-based exceptions such as:
* `RAISE EXCEPTION`
* `RAISE RESUMABLE EXCEPTION`
* `RAISE SHORTDUMP`
* `THROW` ( in conditions )

## What to do in case of exception?
In special cases you can suppress this check’s findings by using the pseudo comment `“#EC NON_CL_EXCEPT`.

## Example
```abap
RAISE SYSTEM-EXCEPTIONS.  "#EC NON_CL_EXCEPT

RAISE ex_name. "#EC NON_CL_EXCEPT

MESSAGE msg_name RAISING ex_name. "#EC NON_CL_EXCEPT
```

## Further Readings & Knowledge
* [ABAP Styleguides on Clean Code](https://github.com/SAP/styleguides/blob/master/clean-abap/CleanABAP.md#use-class-based-exceptions)
