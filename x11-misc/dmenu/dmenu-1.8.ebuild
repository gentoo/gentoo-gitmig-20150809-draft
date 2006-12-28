# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dmenu/dmenu-1.8.ebuild,v 1.1 2006/12/28 07:25:35 omp Exp $

inherit toolchain-funcs

DESCRIPTION="A generic and efficient dynamic menu for X"
HOMEPAGE="http://tools.suckless.org/"
SRC_URI="http://suckless.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/^PREFIX/s/=.*/= \/usr/" \
		-e "/^X11INC/s/=.*/= \/usr\/include/" \
		-e "/^X11LIB/s/=.*/= \/usr\/lib/" \
		-e "/^CFLAGS/s/= -Os/+=/" \
		-e "/^LDFLAGS/s/=/+=/" \
		-e "/^CC/s/=.*/= $(tc-getCC)/" \
		config.mk || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
