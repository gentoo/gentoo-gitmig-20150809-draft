# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-informix/jdbc-informix-221-r5.ebuild,v 1.1 2004/10/20 09:24:55 absinthe Exp $

inherit java-pkg

At="JDBC.2.21.JC5.tar"
S=${WORKDIR}
DESCRIPTION="JDBC Type 4 Drivers for Informix"
SRC_URI="ftp://ftp.software.ibm.com/software/data/informix/downloads/${At}"
HOMEPAGE="http://www-306.ibm.com/software/data/informix/tools/jdbc/"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
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
	use doc && java-pkg_dohtml -r doc/
	java-pkg_dojar lib/ifx*.jar
}
