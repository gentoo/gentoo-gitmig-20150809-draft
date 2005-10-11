# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kword/kword-1.3.5-r1.ebuild,v 1.1 2005/10/11 14:54:10 carlo Exp $

KMNAME=koffice
MAXKOFFICEVER=1.3.5
inherit kde-meta eutils

DESCRIPTION="KOffice Word Processor"
HOMEPAGE="http://www.koffice.org/"
SRC_URI="$SRC_URI mirror://kde/stable/${KMNAME}/src/${KMNAME}-${PV}.tar.bz2"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ppc ~ppc64 x86"
IUSE=""
SLOT="0"
DEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	>=app-text/wv2-0.1.8
	>=media-gfx/imagemagick-5.4.5
	dev-util/pkgconfig"
PATCHES=""

KMCOPYLIB="
	libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkoscript lib/koscript
	libkospell lib/kospell
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store"

KMEXTRACTONLY="lib/"

KMCOMPILEONLY="filters/liboofilter"

KMEXTRA="filters/kword"

need-kde 3.1

PATCHES="${FILESDIR}/koffice_1_3_xpdf_buffer_overflow.diff
	${FILESDIR}/CAN-2005-0064.patch
	${FILESDIR}/koffice-1.4.1-rtfimport.patch"

src_unpack() {
	kde-meta_src_unpack unpack

	# We need to compile first liboofilter because it's needed by the kword's OOo filters
	echo "SUBDIRS = liboofilter kword" > $S/filters/Makefile.am

	kde-meta_src_unpack makefiles
}

