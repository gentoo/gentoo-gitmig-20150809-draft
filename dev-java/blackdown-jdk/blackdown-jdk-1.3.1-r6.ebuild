# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.3.1-r6.ebuild,v 1.1 2002/05/26 20:04:17 karltk Exp $

SYSTEM_ARCH=`echo $ARCH |\
  sed -e s/[i]*.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/`
if [ -z "$SYSTEM_ARCH" ]
then
	SYSTEM_ARCH=`uname -m |\
    sed -e s/[i]*.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/`
fi 

PLATFORM="i386"
FCS="FCS"
MY_P="j2sdk-1.3.1-FCS-linux-i386.tar.bz2"

case $SYSTEM_ARCH in
	ppc)
		PLATFORM="ppc"
		FCS="FCS-02b"
		MY_P="j2sdk-1.3.1-02b-FCS-linux-ppc.bin"
		;;

	i386)
		PLATFORM="i386"
		#Change FCS if you want to use a beta version
		FCS="FCS"
		MY_P="j2sdk-1.3.1-FCS-linux-i386.tar.bz2"
		;;

	sparc)
		;;

	sparc64)
		;;
esac

S=${WORKDIR}/j2sdk1.3.1
DESCRIPTION="Blackdown Java Development Kit 1.3.1"
SRC_URI="ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/${PLATFORM}/${FCS}/${MY_P}"
HOMEPAGE="http://www.blackdown.org"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.0"
	
RDEPEND="$DEPEND"
PROVIDE="virtual/jdk-1.3
	virtual/jre-1.3
	virtual/java-scheme-2"

src_unpack () {
	if [ $PLATFORM = "ppc" ]; then
		tail +400 ${DISTDIR}/${MY_P} > j2sdk-1.3.1-ppc.tar.bz2
		tar -xjf j2sdk-1.3.1-ppc.tar.bz2
	else
	unpack ${MY_P}
	fi
}


src_install () {

	dodir /opt/${P}

	cp -dpR ${S}/{bin,jre,lib,man,include,include-old} ${D}/opt/${P}

	dodir /opt/${P}/share/java
	cp -R ${S}/{demo,src.jar} ${D}/opt/${P}/share
	
	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/${P}/jre/plugin/${PLATFORM}/mozilla/javaplugin_oji.so /usr/lib/mozilla/plugins/javaplugin_oji.so
	fi	

	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	mv ${D}/opt/${P}/jre/lib/font.properties ${D}/opt/${P}/jre/lib/font.properties.orig
	sed "s/standard symbols l/symbol/g" \
		< ${D}/opt/${P}/jre/lib/font.properties.orig \
		> ${D}/opt/${P}/jre/lib/font.properties
	rm ${D}/opt/${P}/jre/lib/font.properties.orig
	
	dodir /etc/env.d/java
	sed \
		-e "s/@P@/${P}/g" \
		-e "s/@PV@/${PV}/g" \
		-e "s/@PF@/${PF}/g" \
		< ${FILESDIR}/blackdown-jdk-${PV} \
		> ${D}/etc/env.d/java/20blackdown-jdk-${PV}
}

pkg_postinst () {
	if [ "`use mozilla`" ] ; then
		einfo "The Mozilla browser plugin has been installed as /usr/lib/mozilla/plugins/javaplugin_oji.so"
	else 
		einfo "For instructions on installing the ${P} browser plugin for"
		einfo "Netscape and Mozilla, see /usr/share/doc/${P}/INSTALL."
	fi
}

