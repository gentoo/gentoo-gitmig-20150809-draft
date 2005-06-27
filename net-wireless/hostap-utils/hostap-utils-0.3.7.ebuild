# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostap-utils/hostap-utils-0.3.7.ebuild,v 1.3 2005/06/27 09:06:12 dholm Exp $

inherit toolchain-funcs

DESCRIPTION="HostAP wireless utils"

HOMEPAGE="http://hostap.epitest.fi/"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"

IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {

	dosbin hostap_{crypt_conf,diag,fw_load,io_debug,rid}
	dosbin prism2_{param,srec}
	dosbin split_combined_hex

	dodoc README
}
