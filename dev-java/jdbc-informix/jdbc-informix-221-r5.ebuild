# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-informix/jdbc-informix-221-r5.ebuild,v 1.3 2005/04/03 19:51:56 axxo Exp $

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

src_unpack() {
	einfo "Unpacking archive ..."
	tar xf ${DISTDIR}/${At}
}

src_compile() {
	einfo "Running InstallShield to extract ..."
	addpredict /root/vpd.properties
	addpredict /var/lib/rpm/
	`/usr/bin/java-config --java` -jar setup.jar -P  product.installLocation=. -silent
}

src_install() {
	use doc && dodoc doc/release/jdbc4pg.pdf
	use doc && java-pkg_dohtml -r doc/
	java-pkg_dojar lib/ifx*.jar
}
