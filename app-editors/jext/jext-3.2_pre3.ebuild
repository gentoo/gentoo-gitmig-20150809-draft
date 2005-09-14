# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jext/jext-3.2_pre3.ebuild,v 1.19 2005/09/14 00:33:08 dang Exp $

inherit java-pkg

DESCRIPTION="A cool and fully featured editor in Java"
HOMEPAGE="http://www.jext.org/"
MY_PV="${PV/_}"
SRC_URI="mirror://sourceforge/jext/${PN}-sources-${MY_PV}.tar.gz"
LICENSE="|| ( GPL-2 JPython )"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="doc"

RDEPEND=">=virtual/jre-1.3
	${RDEPEND}
	>=dev-java/jython-2.1-r5"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core"

S=${WORKDIR}/${PN}-sources-${MY_PV}

src_compile() {
	cd ${S}/src
	local antflags="jar -Dclasspath=$(java-pkg_getjars jython)"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "compile failed"
}

src_install () {
	java-pkg_dojar lib/*.jar
	exeinto /usr/bin
	newexe ${FILESDIR}/jext-gentoo.sh jext
	use doc && java-pkg_dohtml -A .css .gif .jpg -r docs/api
}
