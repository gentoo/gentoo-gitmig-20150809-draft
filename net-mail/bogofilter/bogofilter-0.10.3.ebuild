# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/bogofilter/bogofilter-0.10.3.ebuild,v 1.1 2003/02/15 22:04:49 joker Exp $

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND="virtual/glibc
	>=sys-libs/db-3*"

S=${WORKDIR}/${P}

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS CHANGES-0.10 COPYING METHODS NEWS README README.cvs TODO UPGRADE

	dodir /usr/share/doc/${P}/samples
	mv ${D}/etc/* ${D}/usr/share/doc/${PF}/samples/
	rmdir ${D}/etc

	dohtml doc/*.html
	docinto programmer ; dodoc doc/programmer/*

	einfo "Read bogofilter's manual 'man bogofilter' for tips on how"
	einfo "to integrate bogofilter with procmail and/or mutt."
	einfo ""
	einfo "The former being highly desirable to install in order to"
	einfo "fully use bogofilter."
}
