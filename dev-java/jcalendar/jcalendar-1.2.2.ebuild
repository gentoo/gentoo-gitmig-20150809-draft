# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcalendar/jcalendar-1.2.2.ebuild,v 1.1 2004/12/04 17:34:09 karltk Exp $

inherit eutils java-pkg

DESCRIPTION="Java date chooser bean for graphically picking a date."
SRC_URI="http://www.toedter.com/download/${PN}.zip"
HOMEPAGE="http://www.toedter.com/en/jcalendar/"
LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="~x86 ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.4
	jikes? ( >=dev-java/jikes-1.21 )
	>=dev-java/ant-core-1.4
	=dev-java/jgoodies-looks-bin-1.2*
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jdk-1.4"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}/lib

	rm -f looks-1.2.2.jar
	java-pkg_jar-from jgoodies-looks-bin jgoodies-looks-bin.jar looks-1.2.2.jar
}

src_compile() {
	cd src/

	local antflags="jar"
	if use doc; then
		antflags="${antflags} javadocs"
	fi
	if use jikes; then
		antflags="${antflags} -Dbuild.compiler=jikes"
	fi
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar lib/jcalendar.jar

	dodoc jcalendar-license.txt readme.txt
	if use doc; then
		java-pkg_dohtml -r doc/*
	fi
}
