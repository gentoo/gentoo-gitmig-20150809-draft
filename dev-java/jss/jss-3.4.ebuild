# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jss/jss-3.4.ebuild,v 1.3 2005/03/23 14:28:03 gustavoz Exp $

inherit eutils java-pkg

RTM_NAME="JSS_${PV//./_}_RTM"
DESCRIPTION="Network Security Services for Java (JSS)"
HOMEPAGE="http://www.mozilla.org/projects/security/pki/jss/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/security/${PN}/releases/${RTM_NAME}/src/${P}-src.tar.gz"

LICENSE="MPL-1.1"
SLOT="3.4"
KEYWORDS="x86 amd64 ~sparc"
IUSE=""

S=${WORKDIR}/${P}-src

DEPEND=">=virtual/jdk-1.4
	app-arch/zip
	>=sys-apps/sed-4"
RDEPEND=">=virtual/jre-1.4
	>=dev-libs/nspr-4.3
	>=dev-libs/nss-3.9.2"

src_unpack() {
	unpack ${A}
	cd ${S}/mozilla/security/coreconf
	cp Linux2.5.mk Linux2.6.mk


	echo "INCLUDES += -I${ROOT}usr/include/nss -I${ROOT}usr/include/nspr" \
		>> ${S}/mozilla/security/coreconf/headers.mk

	if use x86; then
		sed -e 's:-L$(DIST)/lib:-L/usr/lib/nspr -L/usr/lib/nss -L$(JAVA_HOME)/jre/lib/i386 -L$(JAVA_HOME)/jre/lib/i386/server -L$(DIST)/lib:' \
			-i ${S}/mozilla/security/jss/lib/config.mk
	elif use amd64; then
		sed -e 's:-L$(DIST)/lib:-L/usr/lib/nspr -L/usr/lib/nss -L$(JAVA_HOME)/jre/lib/amd64 -L$(JAVA_HOME)/jre/lib/amd64/server -L$(DIST)/lib:' \
			-i ${S}/mozilla/security/jss/lib/config.mk
	elif use sparc; then
		sed -e 's:-L$(DIST)/lib:-L/usr/lib/nspr -L/usr/lib/nss -L$(JAVA_HOME)/jre/lib/sparc -L$(JAVA_HOME)/jre/lib/sparc/server -L$(DIST)/lib:' \
			-i ${S}/mozilla/security/jss/lib/config.mk
	fi
}

src_compile() {
	cd ${S}/mozilla/security/coreconf
	emake -j1 BUILD_OPT=1 || die "coreconf make failed"

	cd ${S}/mozilla/security/jss
	emake -j1 BUILD_OPT=1 || die "nss make failed"
}

src_install () {
	cd ${S}/mozilla/dist/classes*
	zip -q -r ../jss34.jar .
	java-pkg_dojar ../jss34.jar

	cd ${S}
	java-pkg_doso mozilla/dist/Linux*/lib/libjss3.so
}
