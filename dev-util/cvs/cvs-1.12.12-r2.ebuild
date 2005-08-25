# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs/cvs-1.12.12-r2.ebuild,v 1.1 2005/08/25 06:21:03 robbat2 Exp $

inherit eutils pam

DESCRIPTION="Concurrent Versions System - source code revision control tools"
HOMEPAGE="http://www.cvshome.org/"

SRC_URI="http://ccvs.cvshome.org/files/documents/19/872/${P}.tar.bz2
	doc? ( http://ccvs.cvshome.org/files/documents/19/878/cederqvist-${PV}.html.tar.bz2
		http://ccvs.cvshome.org/files/documents/19/881/cederqvist-${PV}.pdf
		http://ccvs.cvshome.org/files/documents/19/880/cederqvist-${PV}.ps )"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"

IUSE="crypt doc emacs kerberos pam"

DEPEND="virtual/libc
	>=sys-libs/zlib-1.1.4
	kerberos? ( virtual/krb5 )
	pam? ( virtual/pam )"

src_unpack() {
	unpack ${P}.tar.bz2
	use doc && unpack cederqvist-${PV}.html.tar.bz2
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-1.12.12-cvsbug-tmpfix.patch
}

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

	newpamd ${FILESDIR}/cvs.pam-include cvs
}

src_test() {
	einfo "FEATURES=\"maketest\" has been disabled for dev-util/cvs"
}
