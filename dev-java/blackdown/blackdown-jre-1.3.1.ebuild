# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown/blackdown-jre-1.3.1.ebuild,v 1.1 2001/09/27 21:41:44 karltk Exp $

A=j2re-1.3.1-FCS-linux-i386.tar.bz2
S=${WORKDIR}/j2re1.3.1
DESCRIPTION="Java Runtime Environment"
SRC_URI="ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/i386/FCS/${A}"
HOMEPAGE="http://www.blackdown.org"

DEPEND="virtual/glibc"

#PROVIDE="virtual/java"

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
}

pkg_postinst () {
	einfo "For instructions on installing the ${P} browser plugin for"
	einfo "Netscape and Mozilla, see /usr/share/doc/${P}/INSTALL."
}
