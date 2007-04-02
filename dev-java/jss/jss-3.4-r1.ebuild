# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jss/jss-3.4-r1.ebuild,v 1.5 2007/04/02 16:20:40 betelgeuse Exp $

inherit eutils java-pkg-2 versionator linux-info

RTM_NAME="JSS_${PV//./_}_RTM"
DESCRIPTION="Network Security Services for Java (JSS)"
HOMEPAGE="http://www.mozilla.org/projects/security/pki/jss/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/security/${PN}/releases/${RTM_NAME}/src/${P}-src.tar.gz"

LICENSE="MPL-1.1"
SLOT="3.4"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4
		>=dev-libs/nspr-4.3
		>=dev-libs/nss-3.9.2"
DEPEND=">=virtual/jdk-1.4
		${RDEPEND}
		app-arch/zip
		>=sys-apps/sed-4"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-target_source.patch"
	cd ${S}/mozilla/security/coreconf
	cp Linux2.5.mk Linux$(get_version_component_range 1-3 ${KV}).mk
	cp Linux2.5.mk Linux$(get_version_component_range 1-2 ${KV}).mk

	echo "INCLUDES += -I/usr/include/nss -I/usr/include/nspr" \
		>> ${S}/mozilla/security/coreconf/headers.mk

	if use x86; then
		sed -e 's:-L$(DIST)/lib:-L/usr/lib/nspr -L/usr/lib/nss -L$(JAVA_HOME)/jre/lib/i386 -L$(JAVA_HOME)/jre/lib/i386/server -L$(DIST)/lib:' \
			-i ${S}/mozilla/security/jss/lib/config.mk
	elif use amd64; then
		sed -e 's:-L$(DIST)/lib:-L/usr/lib/nspr -L/usr/lib/nss -L$(JAVA_HOME)/jre/lib/amd64 -L$(JAVA_HOME)/jre/lib/amd64/server -L$(DIST)/lib:' \
			-i ${S}/mozilla/security/jss/lib/config.mk
	fi
}

src_compile() {
	export JAVA_GENTOO_OPTS="-target $(java-pkg_get-target) -source $(java-pkg_get-source)"
	cd ${S}/mozilla/security/coreconf
	emake -j1 BUILD_OPT=1 || die "coreconf make failed"

	cd ${S}/mozilla/security/jss
	emake -j1 BUILD_OPT=1 || die "nss make failed"
}

src_install() {
	cd ${S}/mozilla/dist/classes*
	zip -q -r ../jss34.jar . || die "zip failed"
	java-pkg_dojar ../jss34.jar

	cd ${S}
	java-pkg_doso mozilla/security/jss/lib/Linux2*/libjss3.so
}
