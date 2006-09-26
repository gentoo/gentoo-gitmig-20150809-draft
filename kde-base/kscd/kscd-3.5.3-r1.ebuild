# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscd/kscd-3.5.3-r1.ebuild,v 1.2 2006/09/26 20:34:45 deathwing00 Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdemultimedia-3.5-patchset-01.tar.bz2"

DESCRIPTION="KDE CD player"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="$(deprange 3.5.2 $MAXKDEVER kde-base/libkcddb)"

RDEPEND="${DEPEND}"

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
