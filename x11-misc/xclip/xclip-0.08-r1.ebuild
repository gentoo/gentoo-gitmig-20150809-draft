# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xclip/xclip-0.08-r1.ebuild,v 1.4 2006/10/21 03:21:14 agriffis Exp $

S=${WORKDIR}/xclip
DESCRIPTION="Command-line utility to read data from standard in and place it in an X selection for pasting into X applications."
SRC_URI="http://people.debian.org/~kims/xclip/${P}.tar.gz"
HOMEPAGE="http://people.debian.org/~kims/xclip/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXt
		x11-libs/libXext )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xproto
			app-text/rman
			x11-misc/imake )
		virtual/x11 )"

src_compile() {
	xmkmf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} MANPATH=/usr/share/man MANSUFFIX=1 \
		install.man || die
	rm -f ${D}/usr/lib/X11/doc/html/*
	find ${D} -depth -type d | xargs -n1 rmdir 2>/dev/null
	dodoc README CHANGES
}
