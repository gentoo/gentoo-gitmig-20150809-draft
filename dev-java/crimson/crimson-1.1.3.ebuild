# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/crimson/crimson-1.1.3.ebuild,v 1.4 2004/07/14 01:49:55 agriffis Exp $

inherit java-pkg

DESCRIPTION="Apache Crimson XML 1.0 parser"
HOMEPAGE="http://xml.apache.org/crimson/"
SRC_URI="http://xml.apache.org/dist/crimson/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=virtual/jdk-1.3"

src_compile() {
	ant jars docs || die
}

src_install() {
	dojar build/crimson.jar
	dodoc build/ChangeLog
	dohtml build/README.html
	dohtml -r build/docs
	dohtml -r -A class,java,xml build/examples
}
