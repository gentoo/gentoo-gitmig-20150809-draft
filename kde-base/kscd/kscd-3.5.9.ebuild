# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscd/kscd-3.5.9.ebuild,v 1.7 2008/05/18 19:43:23 maekke Exp $

KMNAME=kdemultimedia
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}"

DESCRIPTION="KDE CD player"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/libkcddb-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMCOPYLIB="libkcddb libkcddb"
KMCOMPILEONLY="libkcddb"

PATCHES="${FILESDIR}/kscd-3.5.6-alsa-tests.patch
		${FILESDIR}/kscd-3.5.6-arts.patch"

src_compile() {
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile myconf configure
	cd "$S"/libkcddb && emake configbase.h
	cd "$S"/libkcddb && emake cdinfodialogbase.h
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile make
}
