# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/latencytop/latencytop-0.4.ebuild,v 1.1 2008/04/23 16:04:23 cardoe Exp $

inherit toolchain-funcs

DESCRIPTION="tool for identifying where in the system latency is happening"
HOMEPAGE="http://www.latencytop.org/"
SRC_URI="http://www.latencytop.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="unicode"

RDEPEND="=dev-libs/glib-2*
	sys-libs/ncurses"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:latencytop.trans:/usr/share/misc/latencytop.trans:' latencytop.c || die
}

src_compile() {
	# this sucks, but makefile is worse (for now)
	use_echo() { use $1 && echo $2 || echo $3 ; }
	echoit() { echo "$@" ; "$@" ; }
	echoit \
	$(tc-getCC) \
		${CPPFLAGS} ${CFLAGS} ${LDFLAGS} \
		$(pkg-config glib-2.0 --cflags) \
		*.c -o latencytop \
		$(pkg-config glib-2.0 --libs) \
		$(use_echo unicode -lncursesw -lncurses) \
		|| die
}

src_install() {
	dosbin latencytop || die
	insinto /usr/share/misc
	doins latencytop.trans || die
}
