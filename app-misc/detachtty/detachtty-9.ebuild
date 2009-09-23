# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/detachtty/detachtty-9.ebuild,v 1.8 2009/09/23 16:01:35 patrick Exp $

inherit toolchain-funcs

MY_P="${P/-/_}"

DESCRIPTION="detachtty allows the user to attach/detach from interactive processes across the network.  It is similar to GNU Screen"
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
