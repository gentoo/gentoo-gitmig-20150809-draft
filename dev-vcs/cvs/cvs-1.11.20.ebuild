# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cvs/cvs-1.11.20.ebuild,v 1.2 2010/10/19 05:38:15 leio Exp $

DESCRIPTION="Concurrent Versions System - source code revision control tools"
HOMEPAGE="http://www.cvshome.org/"
SRC_URI="http://ccvs.cvshome.org/files/documents/19/861/${P}.tar.bz2
	doc? ( http://ccvs.cvshome.org/files/documents/19/866/cederqvist-${PV}.html.tar.bz2
		http://ccvs.cvshome.org/files/documents/19/868/cederqvist-${PV}.pdf
		http://ccvs.cvshome.org/files/documents/19/869/cederqvist-${PV}.ps )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="doc emacs"

DEPEND=">=sys-libs/zlib-1.1.4"

src_compile() {
	econf --with-tmpdir=/tmp || die
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
}

src_test() {
	einfo "FEATURES=\"maketest\" has been disabled for dev-vcs/cvs"
}
