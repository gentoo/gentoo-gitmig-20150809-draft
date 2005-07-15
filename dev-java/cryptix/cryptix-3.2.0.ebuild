# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cryptix/cryptix-3.2.0.ebuild,v 1.5 2005/07/15 17:31:24 axxo Exp $

inherit java-pkg

DESCRIPTION="Aims at facilitating the task programmers face in coding, accessing and generating java-bound, both types and values, defined as ASN.1 constructs, or encoded as such."
HOMEPAGE="http://cryptix-asn1.sourceforge.net/"
SRC_URI="mirror://gentoo/cryptix32-20001002-r3.2.0.zip"

LICENSE="CGL"
SLOT="3.2"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.21 )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/build.xml .
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed too build"
}

src_install() {
	java-pkg_dojar lib/cryptix32.jar

	use doc && java-pkg_dohtml doc/api/*
	use source && java-pkg_dosrc src/*
}
