# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/getmail/getmail-4.2.2.ebuild,v 1.2 2004/11/24 09:48:16 ticho Exp $

inherit distutils
IUSE=""
DESCRIPTION="A POP3 mail retriever with reliable Maildir and mbox delivery"
HOMEPAGE="http://www.qcc.ca/~charlesc/software/getmail-4/"
SRC_URI="http://www.qcc.ca/~charlesc/software/getmail-4/old-versions/${P}.tar.gz"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND=">=dev-lang/python-2.3.3"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install

	if has_version "=net-mail/getmail-3*" ; then
		mv ${D}/usr/bin/getmail ${D}/usr/bin/getmail4
		mv ${D}/usr/bin/getmail_maildir ${D}/usr/bin/getmail_maildir4
		mv ${D}/usr/bin/getmail_mbox ${D}/usr/bin/getmail_mbox4
	fi

	# handle docs the gentoo way
	if [ ${P} != ${PF} ]; then
		mv ${D}/usr/share/doc/${P} ${D}/usr/share/doc/${PF}
	fi

	mkdir ${D}/usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/${PF}/*.html ${D}/usr/share/doc/${PF}/*.css ${D}/usr/share/doc/${PF}/html
	gzip --silent ${D}/usr/share/doc/${PF}/*
}

pkg_postinst() {
	if has_version "=net-mail/getmail-3*" ; then
		echo
		ewarn "An already installed instance of getmail v3 was detected. In order to"
		ewarn "co-exist with it the three main scripts of getmail v4 were renamed to"
		ewarn "getmail4, getmail_maildir4, getmail_mbox4."
		echo
	fi
}
