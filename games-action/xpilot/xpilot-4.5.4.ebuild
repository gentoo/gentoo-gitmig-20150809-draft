# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xpilot/xpilot-4.5.4.ebuild,v 1.11 2006/12/01 20:17:34 wolf31o2 Exp $

DESCRIPTION="A multi-player 2D client/server space game"
HOMEPAGE="http://www.xpilot.org/"
SRC_URI="http://xpilot.org/pub/xpilot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	x11-misc/gccmakedep
	x11-misc/imake
	app-text/rman"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:/usr/local:/usr:" \
		-e "s:/man/man:/share/man/man:" \
		Local.config \
		|| die "sed failed"
}

src_compile() {
	# the stuff xpilot puts it /usr/lib should go
	# in /usr/share , but I'm leaving it for now.

	xmkmf || die "xmkmf Makefile creation failed"
	make Makefiles || die "Makefiles problem"
	local f
	for f in $(find . -type f -regex .*Makefile); do
		sed -i \
			-e "s:CDEBUGFLAGS = -O:CDEBUGFLAGS = ${CFLAGS}:" $f \
			|| die "sed $f failed"
	done
	make includes || die "includes problem"
	make depend || die "depend problem"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install problem"
	make DESTDIR="${D}" install.man || die "install.man problem"
}
