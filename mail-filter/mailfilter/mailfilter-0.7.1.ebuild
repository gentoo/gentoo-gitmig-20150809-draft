# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/mailfilter/mailfilter-0.7.1.ebuild,v 1.1 2004/12/09 23:04:15 ticho Exp $

DESCRIPTION="Mailfilter is a utility to get rid of unwanted spam mails"
HOMEPAGE="http://mailfilter.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/mailfilter/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="nls"

DEPEND="virtual/libc"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc INSTALL doc/FAQ ${FILESDIR}/rcfile.example1 ${FILESDIR}/rcfile.example2 \
		README THANKS ChangeLog AUTHORS NEWS TODO
}
