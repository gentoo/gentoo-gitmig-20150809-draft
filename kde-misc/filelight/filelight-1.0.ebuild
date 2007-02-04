# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/filelight/filelight-1.0.ebuild,v 1.1 2007/02/04 00:09:51 troll Exp $

inherit kde

DESCRIPTION="Filelight is a tool to display where the space is used on the harddisk"
HOMEPAGE="http://www.methylblue.com/filelight/"
SRC_URI="http://www.methylblue.com/filelight/packages/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

need-kde 3.4

src_unpack() {
	kde_src_unpack
	sed -i -e 's/Generic Name/GenericName/' ${S}/misc/${PN}.desktop
}
