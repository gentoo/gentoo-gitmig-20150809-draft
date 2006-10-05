# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jswat/jswat-1.7.1-r1.ebuild,v 1.7 2006/10/05 17:55:02 gustavoz Exp $

inherit java-pkg

DESCRIPTION="Extensible graphical Java debugger"
HOMEPAGE="http://www.bluemarsh.com/java/jswat"
SRC_URI="mirror://sourceforge/jswat/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc"
DEPEND=">=virtual/jdk-1.3
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.3"
IUSE="doc"

src_install() {
	java-pkg_dojar jswat.jar parser.jar

	dobin ${FILESDIR}/jswat

	dodoc AUTHORS.txt BUGS.txt HISTORY.txt LICENSE.txt TODO.txt
	dohtml README.html
	use doc && java-pkg_dohtml -r docs
}
