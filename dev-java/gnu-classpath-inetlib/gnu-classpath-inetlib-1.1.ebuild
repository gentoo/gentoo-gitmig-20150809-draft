# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-classpath-inetlib/gnu-classpath-inetlib-1.1.ebuild,v 1.1 2004/10/20 07:01:40 absinthe Exp $

inherit java-pkg

DESCRIPTION="Network extensions library for GNU classpath and classpathx"
HOMEPAGE="http://www.gnu.org/software/classpath/"
SRC_URI="ftp://ftp.gnu.org/gnu/classpath/inetlib-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
	jikes? ( >=dev-java/jikes-1.19 )"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/jessie-0.9.7
	>=dev-java/gnu-crypto-2.0.1
	"
S=${WORKDIR}/inetlib

src_unpack() {
	unpack ${A}
	cd ${S} ; mkdir ext
	(
		cd ext
		java-pkg_jar-from jessie
		java-pkg_jar-from gnu-crypto
	)
}


src_compile() {
	# TODO: Add back jikes support

	econf \
		--enable-smtp \
		--enable-imap \
		--enable-pop3 \
		--enable-nntp \
		--enable-ftp \
		--enable-gopher \
		--with-jsse-jar=$(pwd)/ext \
		--with-javax-security-jar=$(pwd)/ext \
		|| die
	make || die
	if use doc ; then
		make javadoc
	fi
}

src_install() {
	einstall || die
	rm -rf ${D}/usr/share/java
	java-pkg_dojar inetlib.jar
	use doc && java-pkg_dohtml -r docs/*
	dodoc AUTHORS COPYING NEWS README
}
