# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcal/libkcal-3.5.7-r1.ebuild,v 1.6 2007/08/10 14:19:36 angelos Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-04.tar.bz2"

DESCRIPTION="KDE kcal library for KOrganizer etc"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/ktnef)"
RDEPEND="${DEPEND}"

KMCOPYLIB="libktnef ktnef/lib"
KMEXTRACTONLY="libkdepim/email.h"
KMCOMPILEONLY="libemailfunctions/"

src_unpack() {
	kde-meta_src_unpack
	sed -e "s:SUBDIRS = libical versit tests:SUBDIRS = libical versit:" -i libkcal/Makefile.am
}
