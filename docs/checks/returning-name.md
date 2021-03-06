[BACK](../check_documentation.md)

# Returning Name
## What is the Intent of the Check?
Good method names are usually so good that the `RETURNING` parameter does not need a name of its own.  
The name would do little more than parrot the method name or repeat something obvious.

## How to solve the issue?
Calling the `RETURNING` parameter as `RESULT`.

## What to do in case of exception?
You can suppress Code Inspector findings generated by this check using the pseudo comment `"#EC RET_NAME`.   
The pseudo comment has to be placed after the method declaration.

```abap
  METHODS get_name
    RETURNING
      VALUE(name) TYPE string. "#EC RET_NAME
```

## Example
Before the check: 
```abap
  METHODS get_name
    RETURNING
      VALUE(name) TYPE string.
```

After the check:
```abap
  METHODS get_name
    RETURNING
      VALUE(result) TYPE string.
```

## Further Readings & Knowledge
* [ABAP Styleguides on Clean Code](https://github.com/SAP/styleguides/blob/master/clean-abap/CleanABAP.md#consider-calling-the-returning-parameter-result)
