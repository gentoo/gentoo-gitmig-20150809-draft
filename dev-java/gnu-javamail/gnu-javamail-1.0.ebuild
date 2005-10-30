# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-javamail/gnu-javamail-1.0.ebuild,v 1.2 2005/10/30 19:40:40 axxo Exp $

inherit java-pkg

MY_PN="mail"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="GNU implementation of the Javamail API"
HOMEPAGE="http://www.gnu.org/software/classpathx/javamail/"
SRC_URI="mirror://gnu/classpathx/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86"
IUSE="doc jikes"
RDEPEND=">=virtual/jre-1.3
	=dev-java/gnu-jaf-1.0-r1
	=dev-java/gnu-classpath-inetlib-1.0*"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	jikes? ( >=dev-java/jikes-1.19 )"

S=${WORKDIR}/${MY_P}

src_compile() {
	local activation=$(dirname $(java-pkg_getjar gnu-jaf-1 activation.jar))
	local inetlib=$(dirname $(java-pkg_getjar gnu-classpath-inetlib-1.0 inetlib.jar))

	# TODO: Add jikes back	
	# TODO: Useflag this
	econf \
		--with-activation-jar=${activation} \
		--with-inetlib-jar=${inetlib} \
		--enable-smtp \
		--enable-imap \
		--enable-pop3 \
		--enable-nntp \
		--enable-mbox \
		--enable-maildir \
		|| die

	echo "Configure finished. Compiling... Please wait."

	emake || die

	if use doc; then
		emake javadoc || die
	fi
}

src_install() {
	java-pkg_dojar gnumail.jar gnumail-providers.jar || die
	dodoc AUTHORS ChangeLog NEWS README README.*
	use doc && java-pkg_dohtml -r docs/*
}
