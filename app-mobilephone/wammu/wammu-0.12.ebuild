# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/wammu/wammu-0.12.ebuild,v 1.2 2006/04/06 12:32:13 mrness Exp $

inherit distutils

IUSE=""

DESCRIPTION="front-end for gammu (Nokia and others mobiles)"
HOMEPAGE="http://www.cihar.com/gammu/wammu/"
SRC_URI="http://www.cihar.com/gammu/wammu/${P}.tar.bz2"

LICENSE="GPL-2"
IUSE="bluetooth"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

#gnome-bluetooth is used for additional functionality - see bug #101067
RDEPEND=">=dev-python/wxpython-2.4.1.2
	>=dev-python/python-gammu-0.10
	>=app-mobilephone/gammu-1.04.0
	bluetooth? ( net-wireless/gnome-bluetooth )"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_compile() {
	# SKIPWXCHECK: else 'import wx' results in
	# Xlib: connection to ":0.0" refused by server
	SKIPWXCHECK=yes distutils_src_compile
}

src_install() {
	DOCS="AUTHORS FAQ TODO NEWS"
	SKIPWXCHECK=yes distutils_src_install
}
