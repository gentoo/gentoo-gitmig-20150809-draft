# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/libreadline-java/libreadline-java-0.8.0.ebuild,v 1.10 2004/09/07 09:52:01 axxo Exp $

inherit java-pkg

DESCRIPTION="A JNI-wrapper to GNU Readline."
HOMEPAGE="http://java-readline.sourceforge.net/"
SRC_URI="mirror://sourceforge/java-readline/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc ppc ~amd64"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4
	>=sys-libs/libtermcap-compat-1.2.3-r1"

src_compile() {
	make
	use doc && make apidoc
}

#bug 63102
src_test() { :; }

src_install() {
	dolib.so *.so
	dojar *.jar
	use doc && dohtml -r api/*
	dodoc  ChangeLog NEWS README README.1st TODO
}
