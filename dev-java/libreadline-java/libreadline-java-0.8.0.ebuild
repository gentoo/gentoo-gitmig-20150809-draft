# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/libreadline-java/libreadline-java-0.8.0.ebuild,v 1.1 2004/02/16 05:07:34 zx Exp $

inherit java-pkg

DESCRIPTION="A JNI-wrapper to GNU Readline."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/java-readline/${P}-src.tar.gz"
HOMEPAGE="http://java-readline.sourceforge.net/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4"

src_compile() {
	make
	use doc && make apidoc
}

src_install() {
	dolib.so *.so
	dojar *.jar
	use doc && dohtml -r api/*
	dodoc  ChangeLog NEWS README README.1st TODO
}
