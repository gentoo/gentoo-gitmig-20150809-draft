# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/puretls/puretls-0.94_beta4.ebuild,v 1.4 2004/10/22 09:50:36 absinthe Exp $

inherit java-pkg

DESCRIPTION="PureTLS is a free Java-only implementation of the SSLv3 and TLSv1 (RFC2246) protocols"
HOMEPAGE="http://www.rtfm.com/puretls/"
SRC_URI="mirror://gentoo/puretls-0.9b4.tar.gz
	mirror://gentoo/Cryptix-asn1-20011119.tar.gz
	mirror://gentoo/cryptix32-20001002-r3.2.0.zip"
LICENSE="puretls"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jdk-1.4"

S=${WORKDIR}/${PN}-0.9b4

src_unpack() {
	unpack puretls-0.9b4.tar.gz
	mkdir ${S}/cryptix
	cd ${S}/cryptix
	unpack cryptix32-20001002-r3.2.0.zip && unpack Cryptix-asn1-20011119.tar.gz
	cd ${S}
	echo "jdk.version=1.4" >> build.properties
	echo "cryptix.jar=cryptix/cryptix32.jar" >> build.properties
	echo "cryptix-asn1.jar=cryptix/Cryptix-asn1-20011119/cryptix-asn1.jar" >> build.properties
}

src_compile() {
	ant  || die "Unable to compile"
}

src_install () {
	java-pkg_dojar ${S}/build/${PN}.jar
	dodoc ChangeLog CREDITS INSTALL LICENSE README
	use doc && java-pkg_dohtml -r ${S}/build/doc/*
}
