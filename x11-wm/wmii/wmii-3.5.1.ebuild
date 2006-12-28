# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wmii/wmii-3.5.1.ebuild,v 1.1 2006/12/28 07:32:42 omp Exp $

inherit toolchain-funcs

DESCRIPTION="A dynamic window manager for X11"
HOMEPAGE="http://wmii.suckless.org/"
SRC_URI="http://suckless.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/libixp
	x11-libs/libX11"
RDEPEND="${DEPEND}
	x11-misc/dmenu"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/^PREFIX/s/=.*/= \/usr/" \
		-e "/^CONFPREFIX/s/=.*/= \/etc/" \
		-e "/^X11INC/s/=.*/= \/usr\/include/" \
		-e "/^X11LIB/s/=.*/= \/usr\/lib/" \
		-e "/^CFLAGS/s/= -Os/+=/" \
		-e "/^LDFLAGS/s/=/+=/" \
		-e "/^CC/s/=.*/= $(tc-getCC)/" \
		config.mk || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc LICENSE

	echo -e "#!/bin/sh\n/usr/bin/wmii" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"
}
