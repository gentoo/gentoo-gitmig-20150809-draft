# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tipptrainer/tipptrainer-0.5.0a.ebuild,v 1.1 2004/01/13 03:58:16 pythonhead Exp $

DESCRIPTION="A touch typing trainer (German/English)"
HOMEPAGE="http://www.pingos.org/tipptrainer/index.php"
SRC_URI="mirror://sourceforge/sourceforge/tipptrainer/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=glib-1.2.7
	>=wxGTK-2.4.0"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
