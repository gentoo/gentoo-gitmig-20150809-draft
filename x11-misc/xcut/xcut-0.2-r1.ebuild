# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcut/xcut-0.2-r1.ebuild,v 1.5 2006/10/23 08:33:40 exg Exp $

inherit eutils

IUSE=""
DESCRIPTION="Commandline tool to manipulate the X11 cut and paste buffers"
HOMEPAGE="http://xcut.sourceforge.net"
SRC_URI="mirror://sourceforge/xcut/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc x86"

RDEPEND="|| ( x11-libs/libX11 virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-misc/imake )
	virtual/x11 )
	app-text/rman"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Install to /usr
	sed -i -e 's,/local/bin,/bin,g' \
		-e 's,/local/man,/share/man,g' \
		Imakefile
}

src_compile() {
	xmkmf || die
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	make DESTDIR=${D} install.man || die "make install.man failed"
	rm -f ${D}/usr/lib/X11/doc/html/xcut.1.html
	find ${D} -type d -depth | xargs -n1 rmdir 2>/dev/null
	dodoc README || die "dodoc failed"
}
