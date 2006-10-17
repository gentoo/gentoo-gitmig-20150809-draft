# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/karbon/karbon-1.5.2.ebuild,v 1.9 2006/10/17 20:37:49 kloeri Exp $

MAXKOFFICEVER=${PV}
KMNAME=koffice
inherit kde-meta eutils

DESCRIPTION="KOffice vector drawing application."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)
	>=media-gfx/imagemagick-5.5.2
	>=media-libs/freetype-2
	media-libs/fontconfig
	media-libs/libart_lgpl"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KMCOPYLIB="
	libkformula lib/kformula
	libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkopalette lib/kopalette
	libkotext lib/kotext
	libkwmf lib/kwmf
	libkowmf lib/kwmf
	libkstore lib/store"

KMEXTRACTONLY="lib/"

KMCOMPILEONLY="filters/liboofilter"

KMEXTRA="filters/karbon"

need-kde 3.4

src_unpack() {
	kde-meta_src_unpack unpack

	# We need to compile liboofilter first
	echo "SUBDIRS = liboofilter karbon" > $S/filters/Makefile.am

	kde-meta_src_unpack makefiles
}
