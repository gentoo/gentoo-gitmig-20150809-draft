# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsh/bsh-1.2-r7.ebuild,v 1.1 2003/05/15 03:57:52 absinthe Exp $

inherit java-pkg

At="bsh-1.2b7.jar"
S=${WORKDIR}
DESCRIPTION="BeanShell is a small, free, embeddable, Java source interpreter with object scripting language features."
SRC_URI="http://www.beanshell.org/${At}"
HOMEPAGE="http://www.beanshell.org/"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"
LICENSE="LGPL-2.1"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2"

src_compile() {
	einfo " This ebuild is binary-only (for now)."
	einfo " If you get this to compile from source, please file a bug"
	einfo " and let us know.  http://bugs.gentoo.org/"
}

src_install() {
	dobin ${FILESDIR}/bsh.Console ${FILESDIR}/bsh.Interpreter
	java-pkg_dojar ${DISTDIR}/${At}
}
