# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/activation/activation-20040331.ebuild,v 1.1 2004/03/31 22:59:52 karltk Exp $

inherit java-pkg

DESCRIPTION="GNU implementation of the Java Activation Framework"
HOMEPAGE="http://www.gnu.org/software/classpathx/jaf/"
SRC_URI="http://www.gentoo.org/~karltk/java/distfiles/activation-20040331-gentoo.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4"

src_compile() {
	econf || die
	emake || die
	if $(use doc) ; then
		emake javadoc || die
	fi
}

src_install() {
	java-pkg_dojar activation.jar

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	use doc && dohtml -r docs/*
}

