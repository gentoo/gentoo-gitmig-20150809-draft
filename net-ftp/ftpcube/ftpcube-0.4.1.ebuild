# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpcube/ftpcube-0.4.1.ebuild,v 1.5 2004/06/24 22:45:14 agriffis Exp $

IUSE=""

inherit distutils eutils

DESCRIPTION="Graphical FTP client using wxPython"
SRC_URI="mirror://sourceforge/ftpcube/${P}.tar.gz"
HOMEPAGE="http://ftpcube.sourceforge.net/"
DEPEND=">=dev-python/wxPython-2.4.0.2"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~sparc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch || die "patch failed"
}
