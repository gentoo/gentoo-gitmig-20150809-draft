# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/xpilot/xpilot-4.5.4.ebuild,v 1.3 2004/03/31 03:33:36 mr_bones_ Exp $

DESCRIPTION="A multi-player 2D client/server space game"
HOMEPAGE="http://www.xpilot.org/"
SRC_URI="http://xpilot.org/pub/xpilot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:/usr/local:/usr:" \
		-e "s:/man/man:/share/man/man:" \
		Local.config || die "sed Local.config failed"
}

src_compile() {
	# the stuff xpilot puts it /usr/lib should go
	# in /usr/share , but I'm leaving it for now.

	xmkmf || die "xmkmf Makefile creation failed"
	make Makefiles || die "Makefiles problem"
	local f
	for f in `find . -type f -regex .*Makefile`; do
		sed -i -e "s:CDEBUGFLAGS = -O:CDEBUGFLAGS = ${CFLAGS}:" $f ||
			die "sed $f failed"
	done
	make includes || die "includes problem"
	make depend || die "depend problem"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install problem"
	make DESTDIR="${D}" install.man || die "install.man problem"
}
