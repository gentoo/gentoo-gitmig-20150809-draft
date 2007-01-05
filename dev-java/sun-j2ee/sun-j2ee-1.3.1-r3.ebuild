# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-j2ee/sun-j2ee-1.3.1-r3.ebuild,v 1.5 2007/01/05 23:37:06 caster Exp $

inherit java-pkg eutils

MY_PN="j2sdkee"

DESCRIPTION="Sun's Java 2 Enterprise Edition Development Kit"
SRC_URI="${MY_PN}-1_3_1-linux.tar.gz"
HOMEPAGE="http://java.sun.com/j2ee/sdk_1.3/"
DEPEND=">=sys-libs/lib-compat-1.1"
RDEPEND=">=virtual/jre-1.3.1"
LICENSE="sun-bcla-j2ee"
RESTRICT="fetch"
SLOT="0"
KEYWORDS="~x86 -ppc"
IUSE="doc"

S=${WORKDIR}/${MY_PN}${PV}

pkg_nofetch() {
	die "Please download ${SRC_URI} from ${HOMEPAGE} to ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-scripts.patch
}

src_install() {
	local dirs="bin lib conf config cloudscape lib images nativelib repository public_html logs help images xsl"

	dodir /opt/${P}
	for i in $dirs ; do
		cp -pPR $i ${D}/opt/${P}/
	done

	dodir /etc/env.d/java
	local j2eeenv=${D}/etc/env.d/java/22${P}
	cat > $j2eeenv <<-END
CLASSPATH=/opt/${P}/lib/j2ee.jar
PATH=\${PATH}:/opt/${P}/bin
J2EE_HOME=/opt/${P}
END

	dodoc LICENSE README

	use doc && java-pkg_dohtml -r doc/*
}

pkg_postinst() {
	elog "Remember to set JAVA_HOME before running /opt/${P}/bin/j2ee"
	elog "A set of sample configuration files (that work) can be found in /opt/${P}/conf and /opt/${P}/config"
}
