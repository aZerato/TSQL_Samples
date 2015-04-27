--- 

DECLARE @tableName VARCHAR(8000)
SET @tableName = 'TABLE_NAME'

DECLARE @value VARCHAR(8000)
SET @value = 'error'

DECLARE @columnsName VARCHAR(8000)
DECLARE @columnsCount INT

SELECT @columnsCount = COUNT(*)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME LIKE @tableName

SELECT @columnsName = COALESCE(@columnsName + ' || ', '') + COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME LIKE @tableName

SELECT @columnsName
SELECT @columnsCount

DECLARE @clauseWhere VARCHAR(8000)

if @columnsCount > 1
	SELECT @clauseWhere = REPLACE(@columnsName, '||', 'LIKE ''%' + @value + '%'' OR')
else
	SELECT @clauseWhere = REPLACE(@columnsName, '||', '')

SELECT @clauseWhere = @clauseWhere + ' LIKE ''%' + @value + '%'''

SELECT @clauseWhere

DECLARE @finalRequest VARCHAR(8000)

SELECT @finalRequest = 'SELECT * FROM ' + @tableName + ' WHERE ' + @clauseWhere
SELECT @finalRequest

exec(@finalRequest)
