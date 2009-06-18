# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscd/kscd-3.5.10.ebuild,v 1.5 2009/06/18 04:35:21 jer Exp $

KMNAME=kdemultimedia
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}"

DESCRIPTION="KDE CD player"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-libs/libXext
	>=kde-base/libkcddb-${PV}:${SLOT}"

KMCOPYLIB="libkcddb libkcddb"
KMCOMPILEONLY="libkcddb"

PATCHES=( "${FILESDIR}/kscd-3.5.6-alsa-tests.patch"
		"${FILESDIR}/kscd-3.5.6-arts.patch"
		"${FILESDIR}/kscd-3.5-strict-fix.diff" )

src_compile() {
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile myconf configure
	cd "$S"/libkcddb && emake configbase.h
	cd "$S"/libkcddb && emake cdinfodialogbase.h
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile make
}
