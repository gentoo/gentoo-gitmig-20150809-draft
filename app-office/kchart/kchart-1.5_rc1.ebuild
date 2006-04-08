# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kchart/kchart-1.5_rc1.ebuild,v 1.2 2006/04/08 19:06:17 nixnut Exp $

MAXKOFFICEVER=${PV}
KMNAME=koffice
inherit kde-meta eutils

DESCRIPTION="KOffice integrated graph and chart drawing tool."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KMCOPYLIB="libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store
	libkochart interfaces"

KMEXTRACTONLY="lib/
	interfaces/"

KMEXTRA="filters/kchart"

KMCOMPILEONLY="filters/libdialogfilter"

need-kde 3.4

src_unpack() {
	kde-meta_src_unpack unpack

	# We need to compile liboofilter first
	echo "SUBDIRS = libdialogfilter kchart" > $S/filters/Makefile.am

	kde-meta_src_unpack makefiles
}
