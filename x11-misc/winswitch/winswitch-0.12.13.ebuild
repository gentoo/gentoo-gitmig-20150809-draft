# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/winswitch/winswitch-0.12.13.ebuild,v 1.2 2012/05/22 16:18:07 mr_bones_ Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit python distutils

DESCRIPTION="client server tool to start and control virtual desktops"
HOMEPAGE="http://winswitch.org"
SRC_URI="https://winswitch.org/src/${P}.src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/gst-python
	dev-python/imaging
	dev-python/netifaces
	dev-python/notify-python
	dev-python/pycrypto
	dev-python/pygobject:3
	dev-python/pygtk
	dev-python/twisted
	dev-python/twisted-conch
	media-gfx/xloadimage
	x11-misc/devilspie"
DEPEND=""

src_prepare() {
	einfo "Remove bundled Vash"
	rm -r skel/share/Vash

	python_convert_shebangs -r 2 skel
}

pkg_postinst() {
	elog "You might want to install following packages for additional protocol functionality"
	elog "    net-misc/tigervnc[?server]"
	elog "    x11-wm/xpra[?server]"
	elog "    || ( net-misc/nxclient net-misc/nx ) "
    elog "and net-dns/avahi[python] for automatic server discovery"
}
