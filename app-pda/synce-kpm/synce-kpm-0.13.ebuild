# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-kpm/synce-kpm-0.13.ebuild,v 1.1 2009/01/21 00:34:55 mescalinum Exp $

inherit distutils

DESCRIPTION="The KDE (and Gnome) PDA Manager is an application to manage WM5/WM6 PDA devices from Linux."
HOMEPAGE="http://www.guidodiepen.nl/category/synce/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
# note: some of these could possibly go... not really tested yet.
# note: could use odccm instead of synce-hal, but would require some tweaking.
RDEPEND="dev-python/pygobject
		dev-python/dbus-python
		dev-libs/libxml2
		dev-libs/libxslt
		dev-python/pyxml
		>=app-pda/synce-hal-0.1
		~app-pda/synce-librra-${PV}
		~app-pda/synce-librtfcomp-1.1
		dev-python/PyQt4"
DEPEND="${RDEPEND}
		dev-python/setuptools"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

pkg_postinst() {
	elog "If you want SynCE-KPM to manage partnerships, please emerge synce-sync-engine"
	elog "now.  You can start synce-sync-engine before or after starting SynCE-KPM."
}
