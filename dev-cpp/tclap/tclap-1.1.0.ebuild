# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/tclap/tclap-1.1.0.ebuild,v 1.1 2007/03/18 21:27:04 killerfox Exp $

DESCRIPTION="TCLAP is a small, flexible library that provides a simple interface
for defining and accessing command line arguments."
HOMEPAGE="http://tclap.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR=${D} install || die 'install failed'
}
