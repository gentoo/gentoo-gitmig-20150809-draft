# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xalan/xalan-2.4.1.ebuild,v 1.1 2002/11/01 22:55:19 karltk Exp $

DESCRIPTION="XSLT processor"
HOMEPAGE="http://xml.apache.org/xalan-j/index.html"
LICENSE="Apache-1.1"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-1.4.1
	>=dev-java/xerces-2.2.0
	jikes? ( >=dev-java/jikes-1.16 )"
RDEPEND="$DEPEND"
SRC_URI="http://xml.apache.org/dist/xalan-j/${PN}-j_2_4_1-src.tar.gz"
S=${WORKDIR}/${PN}-j_2_4_1
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~sparc64"
IUSE="jikes"

src_compile() {
	local myc

	# FIXME: Compiling with Jikes does not work properly yet.

	use jikes && \
		myc="${myc} -Dbuild.compiler=jikes" ||
		myc="${myc} -Dbuild.compiler=classic"

	ant jar docs javadocs ${myc} || die "build failed"
}

src_install () {
	dojar build/xalan.jar

	dohtml readme.html
	dohtml -r build/docs/*
}
