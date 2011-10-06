# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dmenu/dmenu-4.4.1.ebuild,v 1.1 2011/10/06 20:31:28 jer Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="a generic, highly customizable, and efficient menu for the X Window System"
HOMEPAGE="http://www.suckless.org/programs/dmenu.html"
SRC_URI="http://dl.suckless.org/tools/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="xinerama"

DEPEND="x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${DEPEND}
	!app-misc/lsx
	!net-dialup/lrzsz"

src_prepare() {
	sed -i \
		-e "s/CFLAGS   = -ansi -pedantic -Wall -Os/CFLAGS  += -ansi -pedantic -Wall/" \
		-e "s/LDFLAGS  = -s/LDFLAGS  +=/" \
		-e "s/XINERAMALIBS  =/XINERAMALIBS  ?=/" \
		-e "s/XINERAMAFLAGS =/XINERAMAFLAGS ?=/" \
		config.mk || die "sed failed"
}

src_compile() {
	if use xinerama; then
		emake CC=$(tc-getCC)
	else
		emake CC=$(tc-getCC) XINERAMAFLAGS="" XINERAMALIBS=""
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
