# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsh/bsh-2.0_beta1.ebuild,v 1.1 2004/02/19 04:12:51 zx Exp $

inherit java-pkg

DESCRIPTION="BeanShell is a small, free, embeddable, Java source interpreter with object scripting language features."
SRC_URI="http://www.beanshell.org/${P/_beta1/b1}.jar"
HOMEPAGE="http://www.beanshell.org/"
KEYWORDS="~x86 ~amd64"
LICENSE="LGPL-2.1"
SLOT="0"
RDEPEND=">=virtual/jdk-1.2"
DEPEND=">=virtual/jre-1.2"

S=${WORKDIR}

src_unpack() { :; }

src_compile() {
	einfo " This ebuild is binary-only (for now)."
	einfo " If you get this to compile from source, please file a bug"
	einfo " and let us know.  http://bugs.gentoo.org/"
}

src_install() {
	dobin ${FILESDIR}/bsh.Console ${FILESDIR}/bsh.Interpreter
	java-pkg_dojar ${DISTDIR}/${P/_beta1/b1}.jar
}
