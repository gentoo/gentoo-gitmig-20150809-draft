# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.3.1-r7.ebuild,v 1.2 2002/04/28 04:12:40 seemant Exp

SYSTEM_ARCH=`echo $ARCH |\
  sed -e s/[i]*.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/`
if [ -z "$SYSTEM_ARCH" ]
then
	SYSTEM_ARCH=`uname -m |\
     sed -e s/[i]*.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/`
fi 

#Change FCS if you want to use a beta version
PLATFORM="i386"
FCS="FCS"
MY_P="j2re-1.3.1-FCS-linux-i386.tar.bz2"

#Adapt for multi-arch:

case $SYSTEM_ARCH in
	ppc)
		PLATFORM="ppc"
		FCS="FCS-02b"
		MY_P="j2re-1.3.1-02b-FCS-linux-ppc.bin"
		;;

	i386)
		PLATFORM="i386"
		#Change FCS if you want to use a beta version
		FCS="FCS"
		MY_P="j2re-1.3.1-FCS-linux-i386.tar.bz2"
		;;

	sparc)
		;;

	sparc64)
		;;
esac


S=${WORKDIR}/j2re1.3.1
DESCRIPTION="Blackdown Java Runtime Environment 1.3.1"
SRC_URI="ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/${PLATFORM}/${FCS}/${MY_P}"
HOMEPAGE="http://www.blackdown.org"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.0"
RDEPEND="$DEPEND"

PROVIDE="virtual/jre-1.3
	virtual/java-scheme-2"

src_unpack () {
	if [ $PLATFORM = "ppc" ]; then
		tail +422 ${DISTDIR}/${MY_P} > j2re-1.3.1-ppc.tar.bz2
		tar -xjf j2re-1.3.1-ppc.tar.bz2
	else
	unpack ${MY_P}
	fi
}

src_install () {
	insinto /opt/${P}
	doins JavaPluginControlPanel.html

	exeinto /opt/${P}/bin
	doexe bin/.java_wrapper bin/awt_robot bin/JavaPluginControlPanel
	doexe bin/j2sdk-config bin/realpath

	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/java
	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/keytool
	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/policytool
	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/rmid
	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/rmiregistry
	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/tnameserv

	exeinto /opt/${P}/bin/${PLATFORM}
	doexe bin/${PLATFORM}/realpath

	exeinto /opt/${P}/bin/${PLATFORM}/green_threads
	doexe bin/${PLATFORM}/green_threads/*

	exeinto /opt/${P}/bin/${PLATFORM}/native_threads
	doexe bin/${PLATFORM}/native_threads/*

	insinto /opt/${P}/lib
	doins lib/*

	dodir /opt/${P}/lib/applet

	insinto /opt/${P}/lib/audio
	doins lib/audio/*

	insinto /opt/${P}/lib/cmm
	doins lib/cmm/*

	dodir /opt/${P}/lib/ext

	insinto /opt/${P}/lib/fonts
	doins lib/fonts/*

	insinto /opt/${P}/lib/${PLATFORM}
	doins lib/${PLATFORM}/*

	insinto /opt/${P}/lib/${PLATFORM}/classic
	doins lib/${PLATFORM}/classic/*

	insinto /opt/${P}/lib/${PLATFORM}/client
	doins lib/${PLATFORM}/client/*

	insinto /opt/${P}/lib/${PLATFORM}/green_threads
	doins lib/${PLATFORM}/green_threads/*

	insinto /opt/${P}/lib/${PLATFORM}/native_threads
	doins lib/${PLATFORM}/native_threads/*

	insinto /opt/${P}/lib/${PLATFORM}/server
	doins lib/${PLATFORM}/server/*

	insinto /opt/${P}/lib/images/cursors
	doins lib/images/cursors/*

	insinto /opt/${P}/lib/locale/de/LC_MESSAGES
	doins lib/locale/de/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/es/LC_MESSAGES
	doins lib/locale/es/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/fr/LC_MESSAGES
	doins lib/locale/fr/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/it/LC_MESSAGES
	doins lib/locale/ja/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/ko/LC_MESSAGES
	doins lib/locale/ko/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/ko.UTF-8/LC_MESSAGES
	doins lib/locale/ko.UTF-8/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/sv/LC_MESSAGES
	doins lib/locale/sv/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/zh/LC_MESSAGES
	doins lib/locale/zh/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/zh.GBK/LC_MESSAGES
	doins lib/locale/zh.GBK/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/zh_TW/LC_MESSAGES
	doins lib/locale/zh_TW/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/zh_TW.BIG5/LC_MESSAGES
	doins lib/locale/zh_TW.BIG5/LC_MESSAGES/*

	insinto /opt/${P}/lib/locale/de/LC_MESSAGES
	doins lib/locale/de/LC_MESSAGES/*

	insinto /opt/${P}/lib/security
	doins lib/security/*

	insinto /opt/${P}/man/ja/man1
	doins man/ja/man1/*

	insinto /opt/${P}/man/man1
	doins man/man1/*

	insinto /opt/${P}/plugin/${PLATFORM}/mozilla
	doins plugin/${PLATFORM}/mozilla/*

	dosym /opt/${P}/plugin/${PLATFORM}/mozilla/ opt/${P}/plugin/${PLATFORM}/netscape6

	insinto /opt/${P}/plugin/${PLATFORM}/netscape4
	doins plugin/${PLATFORM}/netscape4/*
	insinto /opt/${P}/plugin/${PLATFORM}/netscape6
	doins plugin/${PLATFORM}/netscape6/*
	dodir /usr/share
	dodoc COPYRIGHT LICENSE README INSTALL

	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/${P}/plugin/${PLATFORM}/mozilla/javaplugin_oji.so /usr/lib/mozilla/plugins/javaplugin_oji.so
	fi

	mv ${D}/opt/${P}/lib/font.properties ${D}/opt/${P}/lib/font.properties.orig
	sed "s/standard symbols l/symbol/g" \
		< ${D}/opt/${P}/lib/font.properties.orig \
		> ${D}/opt/${P}/lib/font.properties
	rm ${D}/opt/${P}/lib/font.properties.orig
	
        dodir /etc/env.d/java
        sed \
		-e "s/@P@/${P}/g" \
		-e "s/@PV@/${PV}/g" \
		-e "s/@PF@/${PF}/g" \
		< ${FILESDIR}/blackdown-jre-${PV} \
		> ${D}/etc/env.d/java/20blackdown-jre-${PV}
}

pkg_postinst () {

	if [ "`use mozilla`" ] ; then
		einfo "The Mozilla browser plugin has been installed as /usr/lib/mozilla/plugins/javaplugin_oji.so"
	else
		einfo "For instructions on installing the ${P} browser plugin for"
		einfo "Netscape and Mozilla, see /usr/share/doc/${P}/INSTALL."
	fi
}

