# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/jmeter/jmeter-1.8.1.ebuild,v 1.10 2004/04/06 03:22:22 zx Exp $

inherit eutils

IUSE="doc"
MY_P=jakarta-${P}
S=${WORKDIR}/${MY_P}
DOWNLOAD="v1.8/${MY_P}.tgz"
DESCRIPTION="Load test and measure performance on HTTP/FTP services, and databases."
HOMEPAGE="http://jakarta.apache.org/jmeter/index.html"
SRC_URI="http://jakarta.apache.org/builds/jakarta-jmeter/release/${DOWNLOAD}"

SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="x86 -sparc -ppc -alpha -mips -hppa"

DEPEND=">=dev-java/sun-jdk-1.3.1"
RDEPEND=">=dev-java/sun-jdk-1.3.1"

src_compile () {
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install () {
	DIROPTIONS="--mode=0775"
	dodir /opt/${PN}
	cp -ar bin/ lib/ ${D}/opt/${PN}/
	dobin jmeter jmeter-server
	dodoc LICENSE README
	use doc && dohtml -r docs/*
}
