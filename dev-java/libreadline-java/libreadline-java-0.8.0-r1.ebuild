# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/libreadline-java/libreadline-java-0.8.0-r1.ebuild,v 1.7 2004/10/16 23:09:28 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="A JNI-wrapper to GNU Readline."
HOMEPAGE="http://java-readline.sourceforge.net/"
SRC_URI="mirror://sourceforge/java-readline/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/termcap-to-ncurses.patch
}

src_compile() {
	make || die "failed to compile"
	use doc && make apidoc
}

#bug 63102
src_test() { :; }

src_install() {
	dolib.so *.so
	java-pkg_dojar *.jar
	use doc && java-pkg_dohtml -r api/*
	dodoc  ChangeLog NEWS README README.1st TODO
}
