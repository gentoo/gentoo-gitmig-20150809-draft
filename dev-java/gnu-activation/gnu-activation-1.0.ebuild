# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-activation/gnu-activation-1.0.ebuild,v 1.1 2004/10/20 06:26:07 absinthe Exp $

inherit java-pkg

DESCRIPTION="GNU implementation of the Java Activation Framework"
HOMEPAGE="http://www.gnu.org/software/classpathx/jaf/"
SRC_URI="http://ftp.gnu.org/gnu/classpathx/activation-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="doc"
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4"
S=${WORKDIR}/activation-${PV}

src_compile() {
	econf || die
	# package fails in parallel builds
	MAKEOPTS="-j1" emake || die
	if use doc ; then
		MAKEOPTS="-j1" emake javadoc || die
	fi
}

src_install() {
	java-pkg_dojar activation.jar

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	use doc && java-pkg_dohtml -r docs/*
}

