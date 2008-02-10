# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/noweb/noweb-2.11b.ebuild,v 1.1 2008/02/10 18:29:35 aballier Exp $

inherit eutils toolchain-funcs

SRC_URI="http://www.eecs.harvard.edu/~nr/noweb/dist/${P}.tgz"
HOMEPAGE="http://www.eecs.harvard.edu/~nr/noweb/"
LICENSE="freedist"
DESCRIPTION="a literate programming tool, lighter than web"

SLOT="0"
IUSE="examples"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86"	# will test ppc later

DEPEND="virtual/tex-base
	dev-lang/icon
	sys-apps/debianutils"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-2.9-security.patch
	# dont run texhash...
	sed -i -e "s/texhash/true/" Makefile
	# dont strip...
	sed -i -e "s/strip/true/" Makefile
}

src_compile() {
	# noweb tries to use notangle and noweb; see bug #50429
	( cd c; emake ICONC="icont" CC=$(tc-getCC) CFLAGS="${CFLAGS}" LIBSRC="icon" ) || die
	export PATH="${PATH}:${T}"
	emake ICONC="icont" CC=$(tc-getCC) BIN="${T}" LIB="${T}" LIBSRC="icon" install-code \
		|| die "make temporal install failed."

	emake ICONC="icont" CC=$(tc-getCC) CFLAGS="${CFLAGS}" LIBSRC="icon" || die "make failed"
	# Set awk to awk not nawk
	./awkname awk
}

src_install () {
	# It needs the directories to exisst first...
	dodir /usr/bin
	dodir /usr/libexec/${PN}
	dodir /usr/share/man
	dodir /usr/share/texmf/tex/inputs
	emake ICONC="icont" \
		BIN="${D}/usr/bin" \
		LIBSRC="icon" \
		LIBNAME="/usr/libexec/${PN}" \
		LIB="${D}/usr/libexec/${PN}" \
		MAN="${D}/usr/share/man" \
		TEXNAME="/usr/share/texmf/tex/inputs" \
		TEXINPUTS="${D}/usr/share/texmf/tex/inputs" \
		install || die "make install failed"
	cd "${WORKDIR}/${P}"
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
	dodoc CHANGES README
}

pkg_postinst() {
	einfo "Running texhash to complete installation.."
	texhash
}
