# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sud/sud-1.3.ebuild,v 1.1 2004/10/26 23:49:03 lu_zero Exp $

inherit eutils

DESCRIPTION="sud is a daemon to execute interactive and non-interactive processes with special (and customizable) privileges in a nosuid environment"

HOMEPAGE="http://s0ftpj.org/projects/sud/index.htm"

SRC_URI="http://s0ftpj.org/projects/sud/${P}.tar.gz"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="virtual/libc"

src_compile() {

	econf || die
	emake || die "emake failed"

}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog* INSTALL README NEWS TODO
	doman ilogin.1 sud.1 suz.1
	insinto /etc
	doins miscs/sud.conf*
	exeinto /etc/init.d
	newexe ${FILESDIR}/sud.rc6 sud
}
