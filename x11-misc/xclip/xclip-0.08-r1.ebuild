# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xclip/xclip-0.08-r1.ebuild,v 1.5 2007/03/02 20:55:05 drac Exp $

DESCRIPTION="Command-line utility to read data from standard in and place it in an X selection for pasting into X applications."
SRC_URI="http://people.debian.org/~kims/xclip/${P}.tar.gz"
HOMEPAGE="http://people.debian.org/~kims/xclip/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ppc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${PN}"

RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXext"
DEPEND="${RDEPEND}
	app-text/rman
	x11-misc/imake"

src_compile() {
	xmkmf || die "xmkmf failed."
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR=${D} install || die
	emake DESTDIR=${D} MANPATH=/usr/share/man MANSUFFIX=1 \
		install.man || die
	rm -f ${D}/usr/lib/X11/doc/html/*
	find ${D} -depth -type d | xargs -n1 rmdir 2>/dev/null
	dodoc README CHANGES
}
