# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tuxonice-userui/tuxonice-userui-0.7.3.ebuild,v 1.1 2009/01/08 20:11:26 nelchael Exp $

inherit toolchain-funcs eutils

DESCRIPTION="User Interface for TuxOnIce"
HOMEPAGE="http://www.tuxonice.net"
SRC_URI="http://www.tuxonice.net/downloads/all/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	# Package contain binaries
	emake clean

	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		tuxoniceui_text || die "emake tuxoniceui_text failed"
}

src_install() {
	into /
	dosbin tuxoniceui_text
	dodoc AUTHORS ChangeLog KERNEL_API README TODO USERUI_API
}

pkg_postinst() {
	einfo
	einfo "Please see /usr/share/doc/${PF}/README.* for further"
	einfo "instructions."
	einfo
}
