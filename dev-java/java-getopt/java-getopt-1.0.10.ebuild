# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-getopt/java-getopt-1.0.10.ebuild,v 1.4 2005/08/18 18:32:34 hansmi Exp $

inherit java-pkg

DESCRIPTION="Java command line option parser"
HOMEPAGE="http://www.urbanophile.com/arenn/hacking/download.html"
SRC_URI="ftp://ftp.urbanophile.com/pub/arenn/software/sources/java-getopt-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="1"
DEPEND=">=virtual/jdk-1.2
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.2"
KEYWORDS="amd64 ppc x86"
IUSE=""

S=${WORKDIR}

src_compile() {
	mv gnu/getopt/buildx.xml build.xml
	ant all || die "failed to build"
}

src_install() {
	java-pkg_dojar build/lib/gnu.getopt.jar
	java-pkg_dohtml -r build/api/*
	dodoc gnu/getopt/COPYING.LIB gnu/getopt/ChangeLog gnu/getopt/README
}
