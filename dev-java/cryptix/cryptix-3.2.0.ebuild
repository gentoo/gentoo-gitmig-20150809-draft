# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cryptix/cryptix-3.2.0.ebuild,v 1.1 2004/12/04 19:23:23 karltk Exp $

inherit java-pkg

DESCRIPTION="Aims at facilitating the task programmers face in coding, accessing and generating java-bound, both types and values, defined as ASN.1 constructs, or encoded as such."
HOMEPAGE="http://cryptix-asn1.sourceforge.net/"
SRC_URI="mirror://gentoo/cryptix32-20001002-r3.2.0.zip"
LICENSE="CGL"
SLOT="3.2"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	>=app-arch/unzip-5.50
	jikes?( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}

	cp ${FILESDIR}/build.xml .
}

src_compile() {
	antflags="jar"
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags}
}

src_install() {
	java-pkg_dojar lib/cryptix32.jar

	if use doc; then
		java-pkg_dohtml doc/api/*
	fi
}
