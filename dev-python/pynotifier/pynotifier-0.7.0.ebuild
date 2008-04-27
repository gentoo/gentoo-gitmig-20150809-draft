# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pynotifier/pynotifier-0.7.0.ebuild,v 1.3 2008/04/27 14:20:11 maekke Exp $

inherit distutils

DESCRIPTION="pyNotifier provides an implementation of a notifier/event scheduler."
HOMEPAGE="http://www.bitkipper.net/"
SRC_URI="http://www.bitkipper.net/bytes/debian/dists/unstable/source/${PN}_${PV}.orig.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="qt4 gtk"

DEPEND=""
RDEPEND="dev-python/twisted
	gtk? ( dev-python/pygobject )
	qt4? ( dev-python/PyQt4 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	use qt4 || rm notifier/nf_qt.py
	use gtk || rm notifier/nf_gtk.py
}
