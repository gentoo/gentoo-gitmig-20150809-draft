# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/zeroinstall-injector/zeroinstall-injector-0.31.ebuild,v 1.1 2007/12/04 17:02:45 lack Exp $

inherit distutils

DESCRIPTION="Zeroinstall Injector allows regular users to install software themselves"
HOMEPAGE="http://0install.net/"
SRC_URI="mirror://sourceforge/zero-install/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/pygtk-2.0"

src_install() {
	distutils_src_install

	exeinto "/usr/sbin/"
	doexe "${FILESDIR}/0distutils"

	local BASE_XDG_CONFIG="/etc/xdg/0install.net"
	local BASE_XDG_DATA="/usr/share/0install.net"

	insinto "${BASE_XDG_CONFIG}/injector"
	newins "${FILESDIR}/global.cfg" global

	dodir "${BASE_XDG_DATA}/native_feeds"
}

