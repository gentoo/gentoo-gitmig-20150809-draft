# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/bogofilter/bogofilter-0.11.2.ebuild,v 1.2 2003/06/02 22:53:39 joker Exp $

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~ppc x86 sparc"
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
	
	einfo "With version 0.11 the options of bogofilter are changed."
	einfo "If you update from an old version, you eventually must change"
	einfo "your configuration."
	einfo ""
	einfo "Read bogofilter's manual 'man bogofilter' for tips on how"
	einfo "to integrate bogofilter with procmail and/or mutt."
	einfo ""
	einfo "The former being highly desirable to install in order to"
	einfo "fully use bogofilter."
}
