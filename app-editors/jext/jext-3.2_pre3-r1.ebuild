# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jext/jext-3.2_pre3-r1.ebuild,v 1.5 2009/01/10 13:20:37 ali_bush Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A cool and fully featured editor in Java"
HOMEPAGE="http://www.jext.org/"
MY_PV="${PV/_}"
SRC_URI="mirror://sourceforge/jext/${PN}-sources-${MY_PV}.tar.gz"
LICENSE="|| ( GPL-2 Jython )"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="doc"

COMMON_DEP=">=dev-java/jython-2.1-r5"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEP}"
# FIXME doesn't like building against Java 1.5+
DEPEND="|| (
			=virtual/jdk-1.3*
			=virtual/jdk-1.4*
	)
	${COMMON_DEP}
	dev-java/ant-core"

S=${WORKDIR}/${PN}-sources-${MY_PV}

src_compile() {
	cd ${S}/src
	local antflags="jar -Dclasspath=$(java-pkg_getjars jython)"
	eant ${antflags} $(use_doc javadocs) || die "compile failed"
}

src_install () {
	java-pkg_dojar lib/*.jar
	exeinto /usr/bin
	newexe ${FILESDIR}/jext-gentoo.sh jext
	use doc && java-pkg_dohtml -A .css .gif .jpg -r docs/api
}
