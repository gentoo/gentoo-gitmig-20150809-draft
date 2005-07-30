# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sambasentinel/sambasentinel-0.1.ebuild,v 1.8 2005/07/30 18:31:08 swegener Exp $

DESCRIPTION="SambaSentinel is a GTK frontend to smbstatus"
HOMEPAGE="http://kling.mine.nu/sambasentinel.htm"
SRC_URI="http://kling.mine.nu/files/SambaSentinel-${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND=">=x11-libs/gtk+-1.2"

S="${WORKDIR}"/SambaSentinel

src_install() {
	dobin SambaSentinel
}
