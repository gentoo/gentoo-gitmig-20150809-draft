# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-classpath-inetlib/gnu-classpath-inetlib-1.0.ebuild,v 1.6 2005/07/18 14:05:45 axxo Exp $

inherit java-pkg

DESCRIPTION="Network extensions library for GNU classpath and classpathx"
HOMEPAGE="http://www.gnu.org/software/classpath/"
SRC_URI="ftp://ftp.gnu.org/gnu/classpath/inetlib-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc jikes"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/jessie-0.9.7
	>=dev-java/gnu-crypto-2.0.1
	"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	jikes? ( >=dev-java/jikes-1.19 )"
S=${WORKDIR}/inetlib-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}

	mkdir ext && cd ext
	java-pkg_jar-from jessie

	java-pkg_jar-from gnu-crypto javax-security.jar javax-security-auth-callback.jar
	java-pkg_jar-from gnu-crypto javax-security.jar javax-security-sasl.jar
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
		--with-jsse-jar=${S}/ext \
		--with-javax-security-auth-callback-jar=${S}/ext \
		--with-javax-security-sasl-jar=${S}/ext \
		|| die
	make || die
	if use doc ; then
		make javadoc || die
	fi
}

src_install() {
	einstall || die
	rm -rf ${D}/usr/share/java
	java-pkg_dojar inetlib.jar
	use doc && java-pkg_dohtml -r docs/*
	dodoc AUTHORS COPYING NEWS README
}
