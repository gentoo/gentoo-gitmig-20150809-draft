# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-javamail/gnu-javamail-20040331.ebuild,v 1.8 2004/10/20 07:14:59 absinthe Exp $

inherit java-pkg

DESCRIPTION="GNU implementation of the Javamail API"
HOMEPAGE="http://www.gnu.org/software/classpathx/javamail/"
SRC_URI="http://www.gentoo.org/~karltk/java/distfiles/javamail-${PV}-gentoo.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc javadoc jikes"
RDEPEND=">=virtual/jre-1.3
	dev-java/gnu-activation
	>=dev-java/gnu-classpath-inetlib-1.0"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	jikes? >=dev-java/jikes-1.19"
S=${WORKDIR}/javamail-${PV}

src_compile() {
	# TODO: Add jikes back	
	# TODO: Useflag this
	econf \
		--with-activation-jar=/usr/share/gnu-activation/lib \
		--with-inetlib-jar=/usr/share/gnu-classpath-inetlib/lib \
		--enable-smtp \
		--enable-imap \
		--enable-pop3 \
		--enable-nntp \
		--enable-mbox \
		--enable-maildir \
		|| die
	emake || die
	if use javadoc ; then
		emake javadoc
	fi
}

src_install() {
	java-pkg_dojar gnumail.jar gnumail-providers.jar || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README README.*
	use doc && java-pkg_dohtml -r docs/*
}
