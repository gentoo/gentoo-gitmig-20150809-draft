# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-crypto/gnu-crypto-2.0.1.ebuild,v 1.1 2004/04/01 00:03:58 karltk Exp $

inherit java-pkg

DESCRIPTION="GNU Crypto cryptographic primitives for Java"
HOMEPAGE="http://www.gnu.org/software/gnu-crypto/"
SRC_URI="ftp://ftp.gnupg.org/GnuPG/gnu-crypto/gnu-crypto-2.0.1.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes"
DEPEND="jikes? >=dev-java/jikes-1.19
	>=virtual/jdk-1.3"
RDEPEND=">=virtual/jre-1.3"

src_compile() {
	use jikes && export JAVAC=$(which jikes)
	econf \
		--with-jce=yes \
		--with-sasl=yes \
		|| die
	emake || die
	if use doc ; then
		emake javadoc || die
	fi
}

src_install() {
	einstall || die 
	rm ${D}/usr/share/*.jar

	java-pkg_dojar source/gnu-crypto.jar
	java-pkg_dojar jce/javax-crypto.jar
	java-pkg_dojar security/javax-security.jar
	
	if use doc ; then
		dohtml -r api/*
	fi
}

