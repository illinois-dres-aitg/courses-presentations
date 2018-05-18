set SLIDEPATH=C:\inetpub\wwwroot\courses-presentations\common\xslt
set SLIDECLASSPATH=C:\inetpub\wwwroot\courses-presentations\common\xslt\xalan\serializer.jar
set SLIDECLASSPATH=%SLIDECLASSPATH%;C:\inetpub\wwwroot\courses-presentations\common\xslt\xalan\xalan.jar
set SLIDECLASSPATH=%SLIDECLASSPATH%;C:\inetpub\wwwroot\courses-presentations\common\xslt\xalan\xercesImpl.jar
set SLIDECLASSPATH=%SLIDECLASSPATH%;C:\inetpub\wwwroot\courses-presentations\common\xslt\xalan\xml-apis.jar
set SLIDECLASSPATH=%SLIDECLASSPATH%;C:\inetpub\wwwroot\courses-presentations\common\xslt\xalan\xsltc.jar
set SLIDECLASSPATH=%SLIDECLASSPATH%;C:\inetpub\wwwroot\courses-presentations\common\xslt\

java -classpath %SLIDECLASSPATH% xslt %1 %SLIDEPATH%\slides2.xsl index.html



