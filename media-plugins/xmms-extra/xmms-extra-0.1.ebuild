# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-extra/xmms-extra-0.1.ebuild,v 1.10 2004/09/03 21:21:44 eradicator Exp $

inherit eutils gnuconfig

IUSE=""

DESCRIPTION="extra collection of commandline tools to control xmms"
HOMEPAGE="http://www.xmms.org/files/plugins/xmms-extra/"
SRC_URI="http://www.xmms.org/files/plugins/xmms-extra/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 sparc"

RDEPEND=">=media-sound/xmms-1.2.7"

src_compile() {
	gnuconfig_update
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
