# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/Xorgautoconfig/Xorgautoconfig-0.2.3.ebuild,v 1.4 2006/05/06 20:54:19 flameeyes Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Xorgautconfig generates xorg.conf files for PPC based computers."
HOMEPAGE="http://dev.gentoo.org/~josejx/Xorgautoconfig.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ppc64"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/pciutils"

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed!"
}

src_install() {
	dodir /usr
	into /usr
	dosbin Xorgautoconfig

	exeinto /etc/init.d
	newexe Xorgautoconfig.init Xorgautoconfig

	dodoc ChangeLog
}
