# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.4.2.ebuild,v 1.7 2004/12/14 21:15:58 pythonhead Exp $

IUSE=""

inherit distutils eutils

DESCRIPTION="Graphical FTP client using wxPython"
SRC_URI="mirror://sourceforge/ftpcube/${P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"
DEPEND="virtual/python
	<dev-python/wxpython-2.5.1.3"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~sparc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch || die "patch failed"
}
