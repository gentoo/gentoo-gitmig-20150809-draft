# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscd/kscd-3.5.2.ebuild,v 1.9 2006/09/03 10:18:44 kloeri Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE CD player"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkcddb)"

KMCOPYLIB="libkcddb libkcddb"
KMEXTRACTONLY="
	mpeglib_artsplug/configure.in.in"

KMCOMPILEONLY="libkcddb"

src_compile() {
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile myconf configure
	cd $S/libkcddb && make configbase.h
	cd $S/libkcddb && make cdinfodialogbase.h
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile make
}
