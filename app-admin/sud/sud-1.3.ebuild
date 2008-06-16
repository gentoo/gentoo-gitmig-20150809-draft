# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sud/sud-1.3.ebuild,v 1.5 2008/06/16 14:23:17 drac Exp $

inherit eutils

DESCRIPTION="a daemon to execute processes with special (and customizable) privileges in a nosuid environment."
HOMEPAGE="http://s0ftpj.org/projects/sud/index.htm"
SRC_URI="http://s0ftpj.org/projects/sud/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_unpack() {
	unpack ${A}
	sed -i -e \
		's:chmod 500 $(sbindir)/ilogin:chmod 500 $(DESTDIR)$(sbindir)/ilogin:' \
		"${S}"/login/Makefile.in || die "sed failed."
	sed -i -e \
		's:chmod 555 $(bindir)/suz:chmod 500 $(DESTDIR)$(bindir)/suz:' \
		"${S}"/su/Makefile.in || die "sed failed."
	sed -i -e \
		's:chmod 500 $(sbindir)/sud:chmod 500 $(DESTDIR)$(sbindir)/sud:' \
		"${S}"/sud/Makefile.in || die "sed failed."
}

src_install() {
	make DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog* README NEWS TODO
	doman ilogin.1 sud.1 suz.1
	insinto /etc
	doins miscs/sud.conf*
	newinitd "${FILESDIR}"/sud.rc6 sud
}
