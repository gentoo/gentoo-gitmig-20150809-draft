# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscd/kscd-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:38 danarmak Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE CD player"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND="~kde-base/libkcddb-3.3.1"
DEPEND="
$(deprange-dual $PV $MAXKDEVER kde-base/libkcddb)"

KMCOPYLIB="libkcddb libkcddb"
KMEXTRACTONLY="
	mpeglib_artsplug/configure.in.in"

KMCOMPILEONLY="libkcddb"

src_compile() {
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile myconf configure
	cd $S/libkcddb && make configbase.h
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile make
}
