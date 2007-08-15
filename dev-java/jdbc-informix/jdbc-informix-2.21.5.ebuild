# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-informix/jdbc-informix-2.21.5.ebuild,v 1.1 2007/08/15 09:09:50 caster Exp $

inherit java-pkg

At="JDBC.2.21.JC5.tar"
S=${WORKDIR}
DESCRIPTION="JDBC Type 4 Drivers for Informix"
SRC_URI="ftp://ftp.software.ibm.com/software/data/informix/downloads/${At}"
HOMEPAGE="http://www-306.ibm.com/software/data/informix/tools/jdbc/"
KEYWORDS="amd64 ppc x86"
LICENSE="informix-jdbc"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jre-1.2"
RESTRICT="mirror"
IUSE="doc"

src_unpack() {
	tar xf ${DISTDIR}/${At} || die "failed to unpack"
}

src_compile() {
	addpredict /root/vpd.properties
	addpredict /var/lib/rpm/
	java -jar setup.jar -P  product.installLocation=. -silent
}

src_install() {
	use doc && dodoc doc/release/jdbc4pg.pdf
	use doc && java-pkg_dohtml -r doc/
	java-pkg_dojar lib/ifx*.jar
}
