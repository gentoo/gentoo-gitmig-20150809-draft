# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bsh/bsh-1.3.0.ebuild,v 1.4 2004/03/19 01:12:46 zx Exp $

inherit java-pkg

At="bsh-1.3.0.jar"
S=${WORKDIR}
DESCRIPTION="BeanShell is a small, free, embeddable, Java source interpreter with object scripting language features."
SRC_URI="http://www.beanshell.org/${At}"
HOMEPAGE="http://www.beanshell.org/"
KEYWORDS="x86 amd64 ~ppc"
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
