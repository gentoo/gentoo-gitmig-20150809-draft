# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscd/kscd-3.5.7.ebuild,v 1.7 2007/08/10 14:51:40 angelos Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}"

DESCRIPTION="KDE CD player"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcddb)"

RDEPEND="${DEPEND}"

KMCOPYLIB="libkcddb libkcddb"

KMCOMPILEONLY="libkcddb"

PATCHES="${FILESDIR}/kscd-3.5.6-alsa-tests.patch ${FILESDIR}/kscd-3.5.6-arts.patch"

src_compile() {
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile myconf configure
	cd $S/libkcddb && make configbase.h
	cd $S/libkcddb && make cdinfodialogbase.h
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile make
}
