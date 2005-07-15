# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/puretls/puretls-0.94_beta4.ebuild,v 1.8 2005/07/15 17:32:20 axxo Exp $

inherit java-pkg

DESCRIPTION="PureTLS is a free Java-only implementation of the SSLv3 and TLSv1 (RFC2246) protocols"
HOMEPAGE="http://www.rtfm.com/puretls/"
SRC_URI="mirror://gentoo/puretls-0.9b4.tar.gz"
LICENSE="puretls"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="doc jikes source"
RDEPEND=">=virtual/jre-1.4
	=dev-java/cryptix-asn1-bin-20011119
	=dev-java/cryptix-3.2.0"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

S=${WORKDIR}/${PN}-0.9b4

src_unpack() {
	unpack ${A}
	cd ${S}

	java-pkg_jar-from cryptix-asn1-bin
	java-pkg_jar-from cryptix-3.2
	echo "jdk.version=1.4" >> build.properties
	echo "cryptix.jar=cryptix32.jar" >> build.properties
	echo "cryptix-asn1.jar=cryptix-asn1.jar" >> build.properties
}

src_compile() {
	local antflags="compile"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "Unable to compile"
}

src_install() {
	java-pkg_dojar ${S}/build/${PN}.jar

	dodoc ChangeLog CREDITS INSTALL README
	use doc && java-pkg_dohtml -r ${S}/build/doc/api/*
	use source && java-pkg_dosrc src/COM
}
