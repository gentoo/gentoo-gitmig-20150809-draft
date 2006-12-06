# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konsolekalendar/konsolekalendar-3.5.5.ebuild,v 1.7 2006/12/06 14:39:59 kloeri Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="A command line interface to KDE calendars"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcal)
$(deprange $PV $MAXKDEVER kde-base/libkdepim)"

RDEPEND="${DEPEND}"

KMCOPYLIB="libkcal libkcal
	libkdepim libkdepim"
KMEXTRACTONLY="	libkdepim/"
KMCOMPILEONLY="libkcal"

src_compile() {
	export DO_NOT_COMPILE="libkcal"
	kde-meta_src_compile myconf configure
	cd $S/libkcal; make htmlexportsettings.h
	kde-meta_src_compile make
}
