# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/chname/chname-1.0.ebuild,v 1.3 2010/09/17 09:22:01 robbat2 Exp $

DESCRIPTION="Run a command with a new system hostname."
HOMEPAGE="http://code.google.com/p/chname"
SRC_URI="http://chname.googlecode.com/files/chname-1.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=sys-kernel/linux-headers-2.6.16"
RDEPEND=""

src_compile() {
	emake CFLAGS="${CFLAGS}" chname
}

src_install() {
	dobin chname
	doman chname.1
}

pkg_postinst() {
	elog "Note: chname requires a running 2.6.19 kernel with CONFIG_UTS_NS=y."
}
