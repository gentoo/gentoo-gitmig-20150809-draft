# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-classpath-inetlib/gnu-classpath-inetlib-1.0-r2.ebuild,v 1.7 2007/03/28 18:14:46 betelgeuse Exp $

inherit java-pkg-2

MY_PN="inetlib"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Network extensions library for GNU classpath and classpathx"
HOMEPAGE="http://www.gnu.org/software/classpath/"
SRC_URI="mirror://gnu/classpath/${MY_P}.tar.gz"
LICENSE="GPL-2-with-linking-exception"
SLOT="1.0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc"
RDEPEND=">=virtual/jre-1.3
	>=dev-java/jessie-0.9.7
	>=dev-java/gnu-crypto-2.0.1"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}"
S="${WORKDIR}/${MY_P}"

# TODO we could give configure the lib dir on the live filesystem
# instead of populating ${S}/ext with the jars we need -nichoj
# TODO fix jikes support. Related to bug #89711

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-jdk15.patch"

	mkdir ext && cd ext
	java-pkg_jar-from jessie
	java-pkg_jar-from gnu-crypto javax-security.jar javax-security-auth-callback.jar
	java-pkg_jar-from gnu-crypto javax-security.jar javax-security-sasl.jar
}

src_compile() {
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
		|| die "econf failed"
	emake JAVACFLAGS="${JAVACFLAGS}" || die "emake failed"
	if use doc ; then
		emake javadoc || die "emake javadoc failed"
	fi
}

src_install() {
	einstall || die
	rm -rf ${D}/usr/share/java
	java-pkg_dojar ${MY_PN}.jar
	use doc && java-pkg_dohtml -r docs/*
	dodoc AUTHORS NEWS README
}
