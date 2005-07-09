# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/libreadline-java/libreadline-java-0.8.0-r1.ebuild,v 1.10 2005/07/09 16:06:44 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="A JNI-wrapper to GNU Readline."
HOMEPAGE="http://java-readline.sourceforge.net/"
SRC_URI="mirror://sourceforge/java-readline/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64 ppc64"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.4
	sys-libs/ncurses"
DEPEND=">=virtual/jdk-1.4
	source? ( app-arch/zip )
	${RDEPEND}"
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/termcap-to-ncurses.patch
}

src_compile() {
	make || die "failed to compile"
	if use doc; then
		make apidoc || die "failed to generate docs"
	fi
}

src_install() {
	java-pkg_doso *.so
	java-pkg_dojar *.jar
	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dohtml -r api/*
	dodoc  ChangeLog NEWS README README.1st TODO
}
