# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pastemecli/pastemecli-0.8.ebuild,v 1.2 2005/01/01 15:18:37 eradicator Exp $

DESCRIPTION="Pasteme.COM Command-Line-Client"
HOMEPAGE="http://www.topfx.com"
SRC_URI="http://www.topfx.com/dist/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	dobin pastemecli
	insinto /etc; doins pastemecli.conf
	dodoc AUTHORS README NEWS ChangeLog
}
