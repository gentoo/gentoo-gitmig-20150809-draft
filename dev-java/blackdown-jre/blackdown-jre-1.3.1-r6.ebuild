# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.3.1-r6.ebuild,v 1.3 2002/07/11 06:30:19 drobbins Exp $

MY_P=j2re-1.3.1-FCS-linux-i386
S=${WORKDIR}/j2re1.3.1
DESCRIPTION="Blackdown Java Runtime Environment 1.3.1"
SRC_URI="ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/i386/FCS/${MY_P}.tar.bz2"
HOMEPAGE="http://www.blackdown.org"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.0"
RDEPEND="$DEPEND"

PROVIDE="virtual/jre-1.3
	virtual/java-scheme-2"

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

	exeinto /opt/${P}/bin/i386
	doexe bin/i386/realpath

	exeinto /opt/${P}/bin/i386/green_threads
	doexe bin/i386/green_threads/*

	exeinto /opt/${P}/bin/i386/native_threads
	doexe bin/i386/native_threads/*

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

	insinto /opt/${P}/lib/i386
	doins lib/i386/*

	insinto /opt/${P}/lib/i386/classic
	doins lib/i386/classic/*

	insinto /opt/${P}/lib/i386/client
	doins lib/i386/client/*

	insinto /opt/${P}/lib/i386/green_threads
	doins lib/i386/green_threads/*

	insinto /opt/${P}/lib/i386/native_threads
	doins lib/i386/native_threads/*

	insinto /opt/${P}/lib/i386/server
	doins lib/i386/server/*

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

	insinto /opt/${P}/plugin/i386/mozilla
	doins plugin/i386/mozilla/*

	dosym /opt/${P}/plugin/i386/mozilla /opt/${P}/plugin/i386/netscape6

	insinto /opt/${P}/plugin/i386/netscape4
	doins plugin/i386/netscape4/*

	dodir /usr/share
	dodoc COPYRIGHT LICENSE README INSTALL

	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/${P}/plugin/i386/mozilla/javaplugin_oji.so /usr/lib/mozilla/plugins/javaplugin_oji.so
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
