# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jext/jext-3.2_pre3.ebuild,v 1.14 2004/09/21 12:59:47 axxo Exp $

inherit java-pkg

IUSE="doc"

DESCRIPTION="A cool and fully featured editor in Java"
HOMEPAGE="http://www.jext.org/"
MY_PV="${PV/_}"
SRC_URI="mirror://sourceforge/jext/${PN}-sources-${MY_PV}.tar.gz"
LICENSE="GPL-2 | JPython"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"

DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-1.4.1
	>=dev-java/jython-2.1-r5"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}/${PN}-sources-${MY_PV}

src_compile() {
	cd ${S}/src
	sed -e s:'<property name="classpath" value="" />':"<property name='classpath' value='`java-config --classpath=jython`' />": -i build.xml
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	ant ${antflags} || die "compile failed"
}

src_install () {
	java-pkg_dojar lib/*.jar
	exeinto /usr/bin
	newexe ${FILESDIR}/jext-gentoo.sh jext
	use doc && dohtml -A .css .gif .jpg -r docs/api
}
