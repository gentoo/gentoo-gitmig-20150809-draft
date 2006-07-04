# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsf/bsf-2.3.0-r3.ebuild,v 1.1 2006/07/04 19:08:44 nichoj Exp $

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="Bean Script Framework"
HOMEPAGE="http://jakarta.apache.org/bsf/"
SRC_URI="http://cvs.apache.org/dist/jakarta/${PN}/v${PV}rc1/src/${PN}-src-${PV}.tar.gz mirror://gentoo/bsf-rhino-1.5.patch.bz2"
LICENSE="Apache-1.1"
SLOT="2.3"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~ppc64"
IUSE="doc jython rhino source"

COMMON_DEP="
	jython? ( >=dev-java/jython-2.1-r5 )
	rhino? ( =dev-java/rhino-1.5* )
	=dev-java/servletapi-2.3*"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEP}"

ant_src_unpack() {
	unpack ${A}

	epatch ${WORKDIR}/bsf-rhino-1.5.patch
}

src_compile() {
	use rhino && cp="${cp}:$(java-pkg_getjars rhino-1.5)"
	use jython && cp="${cp}:$(java-pkg_getjars jython)"

	cd ${S}/src/taglib
	eant -Dservlet.jar="$(java-pkg_getjars servletapi-2.3)" compile

	cd ${S}/src
	eant -Dclasspath=${cp} compile $(use_doc javadocs)
}

src_install() {
	java-pkg_dojar src/build/lib/bsf.jar

	use doc && java-pkg_dohtml -r src/build/javadocs/*
	if use source; then
		java-pkg_dosrc src/bsf/src/* src/bsf_debug/src/*
		java-pkg_dosrc src/jsdb/src/* src/taglib/src/org
	fi
}
