# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/passepartout/passepartout-0.6_p1.ebuild,v 1.1 2007/03/22 00:48:06 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="A DTP application for the X Window System"
HOMEPAGE="http://www.stacken.kth.se/project/pptout/"

MY_PV="0.6"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

URL_BASE="http://www.stacken.kth.se/project/pptout/files/"
SRC_URI="${URL_BASE}${MY_P}.tar.bz2
	${URL_BASE}${MY_P}-patch1.patch"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

COMMON_DEPS="=dev-cpp/libxmlpp-1*
	>=dev-libs/libxml2-2
	>=dev-cpp/gtkmm-2.4
	>=dev-cpp/libgnomecanvasmm-2.6
	>=dev-libs/glib-2
	>=dev-libs/libsigc++-2
	>=media-libs/freetype-2
	virtual/fam"

RDEPEND="${COMMON_DEPS}
	dev-libs/libxslt
	virtual/ghostscript"

DEPEND="${COMMON_DEPS}
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS BUGS NEWS README"


src_unpack() {
	unpack "${MY_P}.tar.bz2"
	cd "${S}"

	epatch "${DISTDIR}/${MY_P}-patch1.patch"

	# Fix compilation problems with gcc 4.1
	epatch "${FILESDIR}/${MY_P}-extra_qual.patch"
}
