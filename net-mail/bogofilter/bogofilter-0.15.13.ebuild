# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/bogofilter/bogofilter-0.15.13.ebuild,v 1.2 2003/12/29 20:19:53 seemant Exp $

IUSE=""
DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64 ~ppc64"

DEPEND="virtual/glibc
	app-text/xmlto
	>=sys-libs/db-3"

RDEPEND="virtual/glibc
	>=sys-libs/db-3"

src_install() {
	make install DESTDIR=${D} || die

	exeinto /usr/lib/${PN}/contrib
	doexe contrib/{bogofilter-qfe,bogogrep,mime.get.rfc822,parmtest.sh}
	doexe contrib/{randomtrain,scramble,*.pl}

	insinto /usr/lib/${PN}/contrib
	doins contrib/{README.randomtrain,bogo.R,dot-qmail-bogofilter-default,trainbogo.sh}

	dodoc AUTHORS CHANGES* COPYING INSTALL METHODS NEWS README
	dodoc RELEASE.NOTES* TODO UPGRADE
	dodoc doc/integrating-with-* doc/*.HOWTO contrib/*.example

	dodir /usr/share/doc/${P}/samples
	mv ${D}/etc/* ${D}/usr/share/doc/${PF}/samples/
	rmdir ${D}/etc

	dohtml doc/*.html
	docinto programmer ; dodoc doc/programmer/*
}

pkg_postinst() {
	einfo ""
	einfo "For best results it is recommended to retrain bogofilter"
	einfo "if you upgrade from a version 0.15.4 or older,"
	einfo "because the header handling was improved."
	ewarn "Please read specifically about the new -H option"
	einfo ""
	einfo "Read bogofilter's manual 'man bogofilter' and have a look at"
	einfo "the examples in the doc directory for tips on how"
	einfo "to integrate bogofilter with procmail, maildrop, postfix or qmail."
	einfo ""
}
