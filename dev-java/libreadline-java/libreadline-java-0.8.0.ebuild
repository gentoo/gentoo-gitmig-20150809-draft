# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/libreadline-java/libreadline-java-0.8.0.ebuild,v 1.8 2004/08/29 08:03:48 mr_bones_ Exp $

inherit java-pkg

DESCRIPTION="A JNI-wrapper to GNU Readline."
HOMEPAGE="http://java-readline.sourceforge.net/"
SRC_URI="mirror://sourceforge/java-readline/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~sparc ppc"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4
	>=sys-libs/libtermcap-compat-1.2.3-r1"

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
