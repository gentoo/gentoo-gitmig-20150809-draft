# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jswat/jswat-1.7.1.ebuild,v 1.1 2003/05/24 10:45:47 absinthe Exp $

inherit java-pkg

S="${WORKDIR}/${PN}-${PV}"
DESCRIPTION="Extensible graphical Java debugger for JDK 1.3"
HOMEPAGE="http://www.bluemarsh.com/java/jswat"
SRC_URI="mirror://sourceforge/jswat/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 sparc ppc"
DEPEND=""
RDEPEND=">=virtual/jdk-1.3"
IUSE="doc"

src_compile() {
	einfo " This is a binary (bytecode) only ebuild."
}

src_install () {
	# install jswat classes
	java-pkg_dojar jswat.jar parser.jar
	
	# prepare and install jswat script
	dobin ${FILESDIR}/jswat
	
	# install documents
	dodoc AUTHORS.txt BUGS.txt HISTORY.txt LICENSE.txt TODO.txt
	dohtml README.html
	use doc && dohtml -r docs
}
