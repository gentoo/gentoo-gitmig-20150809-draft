# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmxmms/wmxmms-0.1.4-r1.ebuild,v 1.7 2006/02/07 21:14:48 blubb Exp $

inherit eutils

IUSE=""
MY_P=${P/wm/WM}
S=${WORKDIR}/${MY_P}
DESCRIPTION="WMaker DockApp: XMMS Control App"
HOMEPAGE="http://www.dockapps.com/file.php/id/172/"
SRC_URI="http://www.dockapps.com/download.php/id/252/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ppc ~sparc x86"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}

	# Fix bug #44407
	cd ${S}
	make clean

	# Fix bug #88280
	epatch ${FILESDIR}/wmxmms-middle-click.patch
}

src_compile() {
	econf || die
	emake OPT="${CFLAGS}" || die
}

src_install() {
	dobin src/WMxmms
	dodoc AUTHORS ChangeLog README THANKS TODO
	doman doc/WMxmms.1
}
