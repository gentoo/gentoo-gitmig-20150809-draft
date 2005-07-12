# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-activation/gnu-activation-1.0.ebuild,v 1.4 2005/07/12 13:41:04 axxo Exp $

inherit java-pkg

DESCRIPTION="GNU implementation of the Java Activation Framework"
HOMEPAGE="http://www.gnu.org/software/classpathx/jaf/"
SRC_URI="http://ftp.gnu.org/gnu/classpathx/activation-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="doc"
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4"
S=${WORKDIR}/activation-${PV}

src_compile() {
	econf || die
	emake -j1 || die
	if use doc ; then
		emake -j1 javadoc || die
	fi
}

src_install() {
	java-pkg_dojar activation.jar

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	use doc && java-pkg_dohtml -r docs/*
}

