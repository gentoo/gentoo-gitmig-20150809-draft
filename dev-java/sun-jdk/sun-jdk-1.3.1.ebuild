# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.3.1.ebuild,v 1.1 2002/01/13 01:08:39 karltk Exp $

At="j2sdk-1_3_1_02-linux-i386.bin"
S=${WORKDIR}/jdk1.3.1_02
SRC_URI="$At"
DESCRIPTION="Sun's J2EE Development Kit"
HOMEPAGE="http://java.sun.com/j2se/1.3/download-linux.html"

DEPEND="virtual/glibc"
RDEPEND="$DEPEND"

PROVIDE="virtual/jre-1.3
	virtual/jdk-1.3"
	
src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE}"
	fi
	tail +289 ${DISTDIR}/${At} > install.sfx
	chmod +x install.sfx
	./install.sfx
	rm install.sfx
}

src_install () {
	local dirs="bin include include-old jre lib"
	dodir /opt/${P}
	
	
	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done

	dodoc COPYRIGHT README LICENSE
	dohtml README.html

	doman man/man1/*.1

	dodir /opt/${P}/share/
	cp -a demo src.jar ${D}/opt/${P}/share/

        if [ "`use mozilla`" ] ; then                                           
		dodir /usr/lib/mozilla/plugins                                  
		dosym /opt/${P}/jre/plugin/i386/ns600/libjavaplugin_oji.so /usr/lib/mozilla/plugins/
	fi                            
	
	dodir /etc/env.d
        echo "JAVA_HOME=/opt/${P}" > ${D}/etc/env.d/20java                      
	echo "CLASSPATH=/opt/${P}/jre/lib/rt.jar" >> ${D}/etc/env.d/20java 
}

pkg_postinst () {                                                               
	if [ "`use mozilla`" ] ; then                                           
		einfo "The Mozilla browser plugin has been installed as /usr/lib/mozilla/plugins/libjavaplugin_oji.so"
	else                                                                    
		einfo "To install the Java plugin for Mozilla manually, do:"
		einfo "ln -s /opt/${P}/jre/plugin/i386/mozilla/libjavaplugin_oji.so /usr/lib/mozilla/plugins/"
		einfo '(Make certain the directory /usr/lib/mozilla/plugins exists first)'
	fi                                                                      
}                                                                               
                                                                            