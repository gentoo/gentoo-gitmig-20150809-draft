# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown/blackdown-sdk-1.3.1.ebuild,v 1.1 2001/09/27 21:41:44 karltk Exp $

A=j2sdk-1.3.1-FCS-linux-i386.tar.bz2
S=${WORKDIR}/j2sdk1.3.1
DESCRIPTION="Java Runtime Environment"
SRC_URI="ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/i386/FCS/${A}"
HOMEPAGE="http://www.blackdown.org"

DEPEND="virtual/glibc"

src_install () {

	dodir opt/blackdown-sdk-1.3.1

	cp -R ${S}/{bin,jre,lib,man,include,include-old} ${D}/opt/${P}

	# this is necessary if we want an /opt/java symlink working
	# properly 
	
	dosym /opt/${P}/jre/bin/.java_wrapper /opt/${P}/bin/java
        dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/keytool
        dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/policytool
        dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/rmid
        dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/rmiregistry
        dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/tnameserv
                                       	
	dodir /opt/${P}/share/java
	cp -R ${S}/{demo,src.jar} ${D}/opt/${P}/share
	
	dodoc COPYRIGHT LICENSE README INSTALL README.html
	
}

pkg_postinst () {
	einfo "For instructions on installing the ${P} browser plugin for"
	einfo "Netscape and Mozilla, see /usr/share/doc/${P}/INSTALL."
}
