# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detachtty/detachtty-9.ebuild,v 1.9 2010/01/01 18:39:43 ssuominen Exp $

inherit toolchain-funcs

MY_P="${P/-/_}"

DESCRIPTION="allows the user to attach/detach from interactive processes across the network"
HOMEPAGE="http://packages.debian.org/unstable/admin/detachtty"
SRC_URI="mirror://debian/pool/main/d/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ~sparc"
IUSE=""

DEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin detachtty attachtty || die
	doman detachtty.1 || die
	dosym /usr/share/man/man1/detachtty.1 /usr/share/man/man1/attachtty.1
	dodoc INSTALL README
}
