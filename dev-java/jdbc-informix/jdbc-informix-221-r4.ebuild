# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-informix/jdbc-informix-221-r4.ebuild,v 1.1 2003/05/14 19:54:20 absinthe Exp $

inherit java-pkg

At="jdbc-221-JC4-JAVA.tar"
S=${WORKDIR}
DESCRIPTION="JDBC Type 4 Drivers for Informix"
SRC_URI="ftp://ftp.software.ibm.com/software/data/informix/downloads/${At}"
HOMEPAGE="http://www-3.ibm.com/software/data/informix/"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="informix-jdbc"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2"
RESTRICT="nomirror"
IUSE="doc"

# Necessary because of InstallShield (thanks to carpaski)
addpredict /root/vpd.properties

src_unpack() {
	einfo "Unpacking archive ..."
	tar xf ${DISTDIR}/${At}
}

src_compile() {
	einfo "Running InstallShield to extract ..."
	`/usr/bin/java-config --java` -jar setup.jar -P  product.installLocation=. -silent
}

src_install() {
	use doc && dodoc doc/release/jdbc4pg.pdf
	use doc && dohtml -r doc/
	java-pkg_dojar lib/ifx*.jar
}
