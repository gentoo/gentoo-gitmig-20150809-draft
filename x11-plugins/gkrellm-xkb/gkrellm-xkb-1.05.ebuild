# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-xkb/gkrellm-xkb-1.05.ebuild,v 1.3 2006/05/29 23:10:48 robbat2 Exp $

DESCRIPTION="XKB keyboard switcher for gkrellm2"
HOMEPAGE="http://sweb.cz/tripie/gkrellm/xkb/"
SRC_URI="http://sweb.cz/tripie/gkrellm/xkb/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=app-admin/gkrellm-2"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	insinto /usr/lib/gkrellm2/plugins
	doins xkb.so
	dodoc AUTHORS LICENSE ChangeLog
}
