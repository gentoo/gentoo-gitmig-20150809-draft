# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsf/bsf-2.3.0-r2.ebuild,v 1.17 2005/07/09 15:59:47 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="Bean Script Framework"
HOMEPAGE="http://jakarta.apache.org/bsf/"
SRC_URI="http://cvs.apache.org/dist/jakarta/bsf/v${PV}rc1/src/${PN}-src-${PV}.tar.gz mirror://gentoo/bsf-rhino-1.5.patch.bz2"
LICENSE="Apache-1.1"
SLOT="2.3"
KEYWORDS="x86 ppc sparc amd64 ppc64"
IUSE="doc jikes jython rhino source"

RDEPEND=">=virtual/jre-1.4
	jython? ( >=dev-java/jython-2.1-r5 )
	rhino? ( =dev-java/rhino-1.5* )
	=dev-java/servletapi-2.3*"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( >=dev-java/jikes-1.18 )
	source? ( app-arch/zip )
	${RDEPEND}"

src_unpack() {
	unpack ${A}

	epatch ${WORKDIR}/bsf-rhino-1.5.patch
}

src_compile() {
	use rhino && cp="${cp}:$(java-pkg_getjars rhino-1.5)"
	use jython && cp="${cp}:$(java-pkg_getjars jython)"

	# karltk: fix this
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	cd ${S}/src/taglib
	ant ${antflags} -Dservlet.jar="$(java-pkg_getjars servletapi-2.3)" compile || die "Failed to build taglib"

	cd ${S}/src
	ant ${antflags} -Dclasspath=${cp} compile || die "Failed to build main package"
	if use doc ; then
		ant ${antflags} javadocs || die
	fi
}

src_install() {
	java-pkg_dojar src/build/lib/bsf.jar

	use doc && java-pkg_dohtml -r src/build/javadocs/*
	if use source; then
		java-pkg_dosrc src/bsf/src/* src/bsf_debug/src/*
		java-pkg_dosrc src/jsdb/src/* src/taglib/src/org
	fi
}
