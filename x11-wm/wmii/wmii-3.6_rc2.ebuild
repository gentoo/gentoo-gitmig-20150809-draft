# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wmii/wmii-3.6_rc2.ebuild,v 1.1 2007/02/09 02:29:06 omp Exp $

inherit toolchain-funcs

MY_P=${P/_/-}

DESCRIPTION="A dynamic window manager for X11"
HOMEPAGE="http://wmii.suckless.org/"
SRC_URI="http://suckless.org/download/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND="sys-libs/libixp
	x11-libs/libX11"
RDEPEND="${DEPEND}
	x11-misc/dmenu"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/^PREFIX/s|=.*|= /usr|" \
		-e "/^CONFPREFIX/s|=.*|= /etc|" \
		-e "/^X11INC/s|=.*|= /usr/include|" \
		-e "/^X11LIB/s|=.*|= /usr/lib|" \
		-e "/^CFLAGS/s|=|+=|" \
		-e "/^LDFLAGS/s|=|+=|" \
		-e "/^CC/s|=.*|= $(tc-getCC)|" \
		config.mk || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README

	echo -e "#!/bin/sh\n/usr/bin/wmii" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"
}
