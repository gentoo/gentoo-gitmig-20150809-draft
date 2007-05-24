# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-j2ee/sun-j2ee-1.3.1-r4.ebuild,v 1.3 2007/05/24 20:51:14 betelgeuse Exp $

inherit java-pkg-2 eutils

MY_PN="j2sdkee"

DESCRIPTION="Sun's Java 2 Enterprise Edition Development Kit"
SRC_URI="${MY_PN}-1_3_1-linux.tar.gz"
HOMEPAGE="http://java.sun.com/j2ee/sdk_1.3/"
DEPEND=""
RDEPEND=">=virtual/jre-1.3.1"
LICENSE="sun-bcla-j2ee"
RESTRICT="fetch"
SLOT="0"
KEYWORDS="-ppc x86"
IUSE="doc"

S=${WORKDIR}/${MY_PN}${PV}

pkg_nofetch() {
	die "Please download ${SRC_URI} from ${HOMEPAGE} to ${DISTDIR}"
}

src_install() {
	local dirs="bin lib conf config cloudscape lib images nativelib repository public_html logs help images xsl"

	dodir /opt/${P}
	for i in $dirs ; do
		cp -pPR $i ${D}/opt/${P}/
	done

	java-pkg_regjar "${D}"/opt/${P}/lib/*.jar
	java-pkg_regjar ${D}/opt/${P}/*/*/*.jar

	dodir /etc/env.d/java
	local j2eeenv=${T}/22${P}
	cat > $j2eeenv <<-END
PATH=/opt/${P}/bin
J2EE_HOME=/opt/${P}
END
	doenvd "${j2eeenv}"

	dodoc LICENSE README || die

	use doc && java-pkg_dohtml -r doc/*
}

pkg_postinst() {
	elog "Remember to set JAVA_HOME before running /opt/${P}/bin/j2ee"
	elog "A set of sample configuration files (that work) can be found in /opt/${P}/conf and /opt/${P}/config"
}
