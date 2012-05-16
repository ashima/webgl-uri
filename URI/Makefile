.PHONY: clean forget

# This Makefile expects a BASEPATH variable with the relative (or absolute)
# path to the webgl registry root.

registry.xml auto_history.xml: $(BASEPATH)/extensions/registry.xml
	touch registry.old
# if we have a previous version of the registry, save a list of extensions
	-[ -e registry.xml ] && xsltproc ext_list.xsl registry.xml > registry.old
	cp $(BASEPATH)/extensions/registry.xml .
# make a list of extensions for the new version of the registry
	xsltproc ext_list.xsl registry.xml > registry.new
# get rid of any lingering differential
	rm -f registry.diff
# make sure we have a place to land revision XML fragments
	touch auto_history.xmlf
# if there is a non-zero registry differential, extract it
	-diff -u registry.old registry.new || \
	  diff -u registry.old registry.new | sed -n -e "/^[+-][A-Za-z]/p" \
	  > registry.diff
# if we have a differential to report, build a revision and append it
	-[ -e registry.diff ] \
	  && xsltproc --stringparam date `date "+%Y/%m/%d"` \
	              --stringparam diff "`cat registry.diff`" \
	              auto_rev.xsl auto_rev.xml >> auto_history.xmlf
# finally, make the auto history XML to include in the extension
	echo "<history>" > auto_history.xml
	cat auto_history.xmlf >> auto_history.xml
	echo "</history>" >> auto_history.xml

webgl-uri.json: webgl-uri.json.xsl registry.xml
	xsltproc webgl-uri.json.xsl registry.xml > webgl-uri.json

webgl-uri.json.xml: webgl-uri.json
	printf "<json>" > webgl-uri.json.xml
	cat webgl-uri.json >> webgl-uri.json.xml
	printf "</json>" >> webgl-uri.json.xml

webgl-uri.js: webgl-uri.js.xsl webgl-uri.js.xml webgl-uri.json.xml
	xsltproc webgl-uri.js.xsl webgl-uri.js.xml > webgl-uri.js

extension.xml: extension_template.xsl extension_template.xml \
	       registry.xml auto_history.xml \
               webgl-uri.js webgl-uri.json
	xsltproc extension_template.xsl extension_template.xml > extension.xml

clean:
	rm -f index.html extension.xml webgl-uri.js \
	       webgl-uri.json.xml webgl-uri.json

forget:
	rm -f registry.xml auto_history.xmlf registry.old