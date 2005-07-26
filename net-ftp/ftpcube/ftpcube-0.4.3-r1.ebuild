# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.4.3-r1.ebuild,v 1.9 2005/07/26 12:59:32 dholm Exp $

IUSE=""

inherit distutils virtualx eutils

DESCRIPTION="Graphical FTP client using wxPython"
SRC_URI="mirror://sourceforge/ftpcube/${P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"
DEPEND="virtual/python
	<dev-python/wxpython-2.5.1.3"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ppc sparc x86"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch || die "patch failed"
	sed -i -e "s/EVT_KILL_FOCUS/#EVT_KILL_FOCUS/" ${S}/libftpcube/connectwin.py ||
		die "sed failed on connectwin.py"
}

src_compile() {
	export maketype=distutils_src_compile
	virtualmake
}

src_install() {
	export maketype=distutils_src_install
	virtualmake
}
