# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sud/sud-1.3.ebuild,v 1.2 2004/11/18 16:57:24 lu_zero Exp $

inherit eutils

DESCRIPTION="sud is a daemon to execute interactive and non-interactive processes with special (and customizable) privileges in a nosuid environment"

HOMEPAGE="http://s0ftpj.org/projects/sud/index.htm"

SRC_URI="http://s0ftpj.org/projects/sud/${P}.tar.gz"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="virtual/libc"
src_unpack() {
	unpack ${A}
	sed -i -e \
		's:chmod 500 $(sbindir)/ilogin:chmod 500 $(DESTDIR)$(sbindir)/ilogin:' \
		${S}/login/Makefile.in
	sed -i -e \
		's:chmod 555 $(bindir)/suz:chmod 500 $(DESTDIR)$(bindir)/suz:' \
		${S}/su/Makefile.in || die
	sed -i -e \
		's:chmod 500 $(sbindir)/sud:chmod 500 $(DESTDIR)$(sbindir)/sud:' \
		${S}/sud/Makefile.in || die
}

src_compile() {

	econf || die
	emake || die "emake failed"

}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS COPYING ChangeLog* INSTALL README NEWS TODO
	doman ilogin.1 sud.1 suz.1
	insinto /etc
	doins miscs/sud.conf*
	exeinto /etc/init.d
	newexe ${FILESDIR}/sud.rc6 sud
}
