# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pynotifier/pynotifier-0.5.8.ebuild,v 1.1 2007/08/23 00:08:08 rbu Exp $

inherit distutils

DESCRIPTION="pyNotifier provides an implementation of a notifier/event scheduler."
HOMEPAGE="http://www.bitkipper.net/Package/pynotifier"
SRC_URI="http://www.bitkipper.net/bytes/pynotifier/source/${PN}_${PV}-1.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pygobject
	dev-python/PyQt4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# This would need dev-python/wxpython
	# pynotifier's source: "the WX notifier is deprecated and is no longer maintained"
	rm notifier/nf_wx.py
}
