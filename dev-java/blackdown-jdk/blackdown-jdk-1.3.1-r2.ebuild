# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.3.1-r2.ebuild,v 1.1 2002/01/28 23:00:28 karltk Exp $

A=j2sdk-1.3.1-FCS-linux-i386.tar.bz2
S=${WORKDIR}/j2sdk1.3.1
DESCRIPTION="Java Runtime Environment"
SRC_URI="ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/i386/FCS/${A}"
HOMEPAGE="http://www.blackdown.org"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.1.2"
	
RDEPEND="$DEPEND"
PROVIDE="virtual/jdk-1.3
	 virtual/jre-1.3"

src_install () {

	dodir /opt/${P}

	cp -dpR ${S}/{bin,jre,lib,man,include,include-old} ${D}/opt/${P}

	dodir /opt/${P}/share/java
	cp -R ${S}/{demo,src.jar} ${D}/opt/${P}/share
	
	dodoc COPYRIGHT LICENSE README INSTALL README.html

	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/${P}/jre/plugin/i386/mozilla/javaplugin_oji.so /usr/lib/mozilla/plugins/javaplugin_oji.so
	fi	

	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;
	
	dodir /etc/env.d	
	echo "PATH=/opt/${P}/bin" > ${D}/etc/env.d/21jdk
	echo "JDK_HOME=/opt/${P}" >> ${D}/etc/env.d/21jdk
	echo "JAVA_HOME=/opt/${P}" >> ${D}/etc/env.d/21jdk
	echo "ROOTPATH=/opt/${P}/bin" >> ${D}/etc/env.d/21jdk
	echo "CLASSPATH=/opt/${P}/jre/lib/rt.jar" >> ${D}/etc/env.d/21jdk
	echo "LDPATH=/opt/${P}/jre/lib/i386:/opt/${P}/jre/lib/i386/client" >> ${D}/etc/env.d/21jdk
}

pkg_postinst () {
	if [ "`use mozilla`" ] ; then
		einfo "The Mozilla browser plugin has been installed as /usr/lib/mozilla/plugins/javaplugin_oji.so"
	else 
		einfo "For instructions on installing the ${P} browser plugin for"
		einfo "Netscape and Mozilla, see /usr/share/doc/${P}/INSTALL."
	fi
}
