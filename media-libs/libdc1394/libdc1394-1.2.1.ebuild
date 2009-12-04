# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdc1394/libdc1394-1.2.1.ebuild,v 1.4 2009/12/04 13:59:23 ssuominen Exp $

inherit eutils flag-o-matic

DESCRIPTION="Library to interface with IEEE 1394 cameras following the IIDC specification"
HOMEPAGE="http://sourceforge.net/projects/libdc1394/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="X"

RDEPEND=">=sys-libs/libraw1394-0.9.0
		X? ( x11-libs/libSM x11-libs/libXv )"
DEPEND="${RDEPEND}
	!=sys-libs/libdc1394-1.0.0
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if ! use X; then
		epatch "${FILESDIR}"/${P}-nox11.patch
	fi
}

src_compile() {
	if has_version '>=sys-libs/glibc-2.4' ; then
		append-flags "-DCLK_TCK=CLOCKS_PER_SEC"
	fi

	econf
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README AUTHORS
}
