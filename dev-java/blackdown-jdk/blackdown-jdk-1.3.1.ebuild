# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.3.1.ebuild,v 1.2 2001/12/30 04:06:13 karltk Exp $

A=j2sdk-1.3.1-FCS-linux-i386.tar.bz2
S=${WORKDIR}/j2sdk1.3.1
DESCRIPTION="Java Runtime Environment"
SRC_URI="ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/i386/FCS/${A}"
HOMEPAGE="http://www.blackdown.org"

DEPEND="virtual/glibc"

PROVIDE="virtual/jdk-1.3
	 virtual/jre-1.3"

src_install () {

	dodir /opt/${P}

	cp -R ${S}/{bin,jre,lib,man,include,include-old} ${D}/opt/${P}

	dodir /opt/${P}/share/java
	cp -R ${S}/{demo,src.jar} ${D}/opt/${P}/share
	
	dodoc COPYRIGHT LICENSE README INSTALL README.html

	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/${P}/jre/plugin/i386/mozilla/javaplugin_oji.so /usr/lib/mozilla/plugins/javaplugin_oji.so
	fi	

	dodir /etc/env.d	
	echo "JAVA_HOME=/opt/${P}" > ${D}/etc/env.d/20java
	echo "CLASSPATH=/opt/${P}/jre/lib/rt.jar" >> ${D}/etc/env.d/20java
}

pkg_postinst () {
	if [ "`use mozilla`" ] ; then
		einfo "The Mozilla browser plugin has been installed as /usr/lib/mozilla/plugins/javaplugin_oji.so"
	else 
		einfo "For instructions on installing the ${P} browser plugin for"
		einfo "Netscape and Mozilla, see /usr/share/doc/${P}/INSTALL."
	fi
}
