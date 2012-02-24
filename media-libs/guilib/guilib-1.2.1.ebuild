# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/guilib/guilib-1.2.1.ebuild,v 1.2 2012/02/24 11:02:01 ago Exp $

EAPI=4
inherit autotools

MY_P=GUIlib-${PV}

DESCRIPTION="a simple widget set for SDL"
SRC_URI="http://www.libsdl.org/projects/GUIlib/src/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/GUIlib/"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="static-libs"

RDEPEND=">=media-libs/libsdl-1.0.1"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e '/^noinst_PROGRAMS/,$d' Makefile.am

	rm -f *.m4
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_install() {
	default

	use static-libs || find "${ED}" -name '*.la' -exec rm {} +
}
