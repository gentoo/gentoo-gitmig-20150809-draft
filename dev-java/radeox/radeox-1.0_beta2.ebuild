# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/radeox/radeox-1.0_beta2.ebuild,v 1.6 2004/10/22 10:02:37 absinthe Exp $

inherit java-pkg

DESCRIPTION="Radeox Wiki render engine"
HOMEPAGE="http://www.radeox.org"
SRC_URI="ftp://snipsnap.org/radeox/${PN}-1.0-BETA-2-src.tgz"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"
DEPEND="=dev-java/oro-2.0*
	=dev-java/junit-3.8*
	=dev-java/commons-logging-1.0*
	=dev-java/picocontainer-1.0*"
# karltk: is junit really necessary?
S=${WORKDIR}/${PN}-1.0-BETA-2

src_unpack() {
	unpack ${A}

	rm -f ${S}/lib/*.jar
	(
		cd ${S}/lib
		java-pkg_jar-from junit || die "Failed to link junit"
		java-pkg_jar-from oro || die "Failed to link oro"
		java-pkg_jar-from commons-logging || die "Failed to link commons-logging"
		java-pkg_jar-from picocontainer || die "Failed to link picocontainer"

	)
	rm -rf  ${S}/src/org/radeox/example/ \
		${S}/src/test/ \
		${S}/src/org/radeox/test/
}

src_compile() {
	ant jar jar-api || die "Failed to build jar"
	if use doc ; then
		ant javadoc || die "Failed to build docs"
	fi
}

src_install() {
	dodoc Changes.txt README Radeox.version license.txt
	use doc && java-pkg_dohtml -r docs/api
	java-pkg_dojar lib/{radeox,radeox-api}.jar
}
