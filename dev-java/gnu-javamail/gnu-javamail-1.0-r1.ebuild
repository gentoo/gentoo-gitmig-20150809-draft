# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-javamail/gnu-javamail-1.0-r1.ebuild,v 1.5 2007/03/28 18:15:23 betelgeuse Exp $

inherit java-pkg-2

MY_PN="mail"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="GNU implementation of the Javamail API"
HOMEPAGE="http://www.gnu.org/software/classpathx/javamail/"
SRC_URI="mirror://gnu/classpathx/${MY_P}.tar.gz"
LICENSE="GPL-2-with-linking-exception"
SLOT="1"
KEYWORDS="amd64 x86"
IUSE="doc"
RDEPEND=">=virtual/jre-1.4
	=dev-java/gnu-jaf-1*
	=dev-java/gnu-classpath-inetlib-1.0*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

# TODO: Re-enable jikes support (see bug #89711)

src_compile() {
	local activation=$(dirname $(java-pkg_getjar gnu-jaf-1 activation.jar))
	local inetlib=$(dirname $(java-pkg_getjar gnu-classpath-inetlib-1.0 inetlib.jar))

	econf \
		--with-activation-jar=${activation} \
		--with-inetlib-jar=${inetlib} \
		--enable-smtp \
		--enable-imap \
		--enable-pop3 \
		--enable-nntp \
		--enable-mbox \
		--enable-maildir \
		|| die "failed to configure"

	emake JAVACFLAGS="${JAVACFLAGS}" || die "failed to compile"

	if use doc; then
		emake javadoc || die "failed to generate javadoc"
	fi
}

src_install() {
	java-pkg_dojar gnumail.jar gnumail-providers.jar || die "java-pkg_dojar failed"
	dodoc AUTHORS ChangeLog NEWS README README.*
	use doc && java-pkg_dohtml -r docs/*
}
