# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdiskusage/xdiskusage-1.48_p20100606.ebuild,v 1.6 2011/03/21 11:38:09 hwoarang Exp $

EAPI=3
inherit autotools flag-o-matic

DESCRIPTION="front end to xdu for viewing disk usage graphically under X11"
HOMEPAGE="http://xdiskusage.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/fltk:2"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_prepare() {
	eautoreconf
}

src_configure() {
	append-flags -I/usr/include/fltk/compat
	econf
}

src_compile() {
	emake \
		CXXFLAGS="${CXXFLAGS}" \
		LDLIBS="$(fltk2-config --ldflags)" || die
}

src_install() {
	dobin xdiskusage || die
	doman xdiskusage.1
	dodoc README
}
