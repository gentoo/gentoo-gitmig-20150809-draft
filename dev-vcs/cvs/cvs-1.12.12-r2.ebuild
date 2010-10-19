# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cvs/cvs-1.12.12-r2.ebuild,v 1.2 2010/10/19 05:38:15 leio Exp $

inherit eutils pam

DESCRIPTION="Concurrent Versions System - source code revision control tools"
HOMEPAGE="http://www.cvshome.org/"

SRC_URI="http://ccvs.cvshome.org/files/documents/19/872/${P}.tar.bz2
	doc? ( http://ccvs.cvshome.org/files/documents/19/878/cederqvist-${PV}.html.tar.bz2
		http://ccvs.cvshome.org/files/documents/19/881/cederqvist-${PV}.pdf
		http://ccvs.cvshome.org/files/documents/19/880/cederqvist-${PV}.ps )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"

IUSE="crypt doc emacs kerberos pam"

DEPEND=">=sys-libs/zlib-1.1.4
	kerberos? ( virtual/krb5 )
	pam? ( virtual/pam )"

src_unpack() {
	unpack ${P}.tar.bz2
	use doc && unpack cederqvist-${PV}.html.tar.bz2
	EPATCH_OPTS="-p1 -d ${S}" epatch "${FILESDIR}"/${PN}-1.12.12-cvsbug-tmpfix.patch
}

src_compile() {
	econf \
		--with-external-zlib \
		--with-tmpdir=/tmp \
		--disable-nls \
		`use_enable crypt encryption` \
		`use_enable pam` \
		|| die
	emake || die "emake failed"
}

src_install() {
	einstall || die

	insinto /etc/xinetd.d
	newins "${FILESDIR}"/cvspserver.xinetd.d cvspserver || die "newins failed"

	dodoc BUGS ChangeLog* DEVEL* FAQ HACKING \
		MINOR* NEWS PROJECTS README* TESTS TODO

	if use emacs; then
		insinto /usr/share/emacs/site-lisp
		doins cvs-format.el || die "doins failed"
	fi

	if use doc; then
		dodoc "${DISTDIR}"/cederqvist-${PV}.pdf
		dodoc "${DISTDIR}"/cederqvist-${PV}.ps
		tar xjf "${DISTDIR}"/cederqvist-${PV}.html.tar.bz2
		dohtml -r cederqvist-${PV}.html/*
		cd "${D}"/usr/share/doc/${PF}/html/
		ln -s cvs.html index.html
	fi

	newpamd "${FILESDIR}"/cvs.pam-include-1.12.12 cvs
}

src_test() {
	einfo "FEATURES=\"maketest\" has been disabled for dev-vcs/cvs"
}
