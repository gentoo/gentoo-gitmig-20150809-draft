# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tomcat-native/tomcat-native-1.1.14.ebuild,v 1.1 2008/07/07 18:56:12 wltjr Exp $

inherit eutils java-pkg-2

DESCRIPTION="Native APR library for Tomcat"

SLOT="0"
SRC_URI="mirror://apache/tomcat/tomcat-connectors/native/${P}-src.tar.gz"
HOMEPAGE="http://tomcat.apache.org/"
KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
IUSE=""

RDEPEND="=dev-libs/apr-1*
	dev-libs/openssl
	>=virtual/jre-1.5"

DEPEND=">=virtual/jdk-1.5
	${RDEPEND}"

S=${WORKDIR}/${P}-src

src_compile(){
	cd "${S}"/jni/native

	# set version since upstream is slacking
	sed -i -e 's:1.1.12:1.1.13:' tcnative.spec
	sed -i -e 's:TCN_PATCH_VERSION       12:TCN_PATCH_VERSION       13:' \
		include/tcn_version.h

	econf --with-apr=/usr/bin/apr-1-config  \
		--with-ssl=/usr || die "Could not configure native sources"
	emake || die "Could not build libtcnative-1.so"
}

src_install() {
	cd "${S}"/jni/native
	emake DESTDIR="${D}" install || die "Could not install libtcnative-1.so"
}

pkg_postinst() {
	elog
	elog " APR should be available with Tomcat, for more information"
	elog " please see http://tomcat.apache.org/tomcat-6.0-doc/apr.html"
	elog
	elog " Please report any bugs to http://bugs.gentoo.org/"
	elog
}
