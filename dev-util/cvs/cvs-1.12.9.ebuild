# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs/cvs-1.12.9.ebuild,v 1.3 2004/12/03 16:39:54 scandium Exp $

DESCRIPTION="Concurrent Versions System - source code revision control tools"
HOMEPAGE="http://www.cvshome.org/"

SRC_URI="http://ccvs.cvshome.org/files/documents/19/200/${P}.tar.bz2
	doc? ( http://ccvs.cvshome.org/files/documents/19/205/cederqvist-${PV}.html.tar.bz2
		http://ccvs.cvshome.org/files/documents/19/207/cederqvist-${PV}.pdf
		http://ccvs.cvshome.org/files/documents/19/206/cederqvist-${PV}.ps )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"

IUSE="crypt doc emacs kerberos pam"

DEPEND="virtual/libc
	>=sys-libs/zlib-1.1.4
	kerberos? ( virtual/krb5 )
	pam? ( >=sys-libs/pam-0.73
		>=sys-apps/shadow-4.0.2-r2 )"


src_compile() {
	econf \
		--with-external-zlib \
		--with-tmpdir=/tmp \
		`use_enable crypt encryption` \
		`use_enable pam` \
		|| die
	emake || die "emake failed"
}

src_install() {
	einstall || die

	insinto /etc/xinetd.d
	newins ${FILESDIR}/cvspserver.xinetd.d cvspserver || die "newins failed"

	dodoc BUGS ChangeLog* DEVEL* FAQ HACKING \
		MINOR* NEWS PROJECTS README* TESTS TODO

	if use emacs; then
		insinto /usr/share/emacs/site-lisp
		doins cvs-format.el || die "doins failed"
	fi

	if use doc; then
		dodoc ${DISTDIR}/cederqvist-${PV}.pdf
		dodoc ${DISTDIR}/cederqvist-${PV}.ps
		tar xjf ${DISTDIR}/cederqvist-${PV}.html.tar.bz2
		dohtml -r cederqvist-${PV}.html/*
		cd ${D}/usr/share/doc/${PF}/html/
		ln -s cvs.html index.html
	fi

	if use pam; then
		insinto /etc/pam.d
		newins ${FILESDIR}/cvs.pam cvs
	fi
}

src_test() {
	einfo "FEATURES=\"maketest\" has been disabled for dev-util/cvs"
}
