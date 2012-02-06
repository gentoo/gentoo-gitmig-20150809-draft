# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xosview/xosview-1.9.2.ebuild,v 1.3 2012/02/06 16:18:59 mr_bones_ Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="X11 operating system viewer"
HOMEPAGE="http://www.pogo.org.uk/~mark/xosview/"
SRC_URI="http://www.pogo.org.uk/~mark/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="suid"

COMMON_DEPS="x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXt"
RDEPEND="${COMMON_DEPS}
	media-fonts/font-misc-misc"
DEPEND="${COMMON_DEPS}
	x11-proto/xproto"

src_prepare() {
	sed -e 's:lib/X11/app:share/X11/app:g' \
		-i Xrm.cc config/Makefile.top.in || die
	sed -e 's:$(CFLAGS)::g' \
		-e 's:@EXTRA_CXXFLAGS@::g' \
		-i config/Makefile.config.in || die
	epatch "${FILESDIR}"/${P}-emptyxpaths.patch
	pushd config &> /dev/null
	eautoreconf
	cp configure ../ || die
	popd &> /dev/null
}

src_install() {
	dobin ${PN}
	use suid && fperms 4755 /usr/bin/${PN}
	insinto /usr/share/X11/app-defaults
	newins Xdefaults XOsview
	doman *.1
	dodoc CHANGES README README.linux TODO
}

pkg_postinst() {
    if ! use suid ; then
		ewarn "If you want to use serial meters ${PN} needs to be executed as root."
		ewarn "Please see ${EPREFIX}/usr/share/doc/${PF}/README.linux for details."
	fi
}
