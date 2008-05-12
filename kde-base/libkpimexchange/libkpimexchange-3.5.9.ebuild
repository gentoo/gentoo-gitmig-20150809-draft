# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkpimexchange/libkpimexchange-3.5.9.ebuild,v 1.3 2008/05/12 14:58:36 armin76 Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE PIM exchange library"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/libkcal-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

KMCOPYLIB="libkcal libkcal"
# libkcal is installed because a lot of headers are needed, but it don't have to be compiled
KMEXTRACTONLY="
	libkcal/"
KMCOMPILEONLY="
	libkcal/libical/src/libical/
	libkcal/libical/src/libicalss/"

src_compile() {
	kde-meta_src_compile myconf configure
	# generate "ical.h"
	cd "${S}/libkcal/libical/src/libical" && make ical.h
	# generate "icalss.h"
	cd "${S}/libkcal/libical/src/libicalss" && make icalss.h

	kde-meta_src_compile make
}
