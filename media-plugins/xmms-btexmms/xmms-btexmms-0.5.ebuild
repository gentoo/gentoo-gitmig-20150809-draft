# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-btexmms/xmms-btexmms-0.5.ebuild,v 1.5 2004/11/11 09:49:53 eradicator Exp $

IUSE=""

MY_P=${P/xmms-/}
MY_PN=${PN/xmms-/}
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="Remote control XMMS from your Ericsson phone (using Bluetooth)"
HOMEPAGE="http://www.lyola.com/bte/"
SRC_URI="http://www.lyola.com/bte/${MY_P}.tgz"
SLOT="0"

LICENSE="GPL-2"

KEYWORDS="amd64 ~ppc sparc x86"
DEPEND="media-sound/xmms
	>=net-wireless/bluez-utils-2.3"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog CREDITS INSTALL README
}
