# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/batterymon/batterymon-1.2.0.ebuild,v 1.1 2009/12/12 10:44:25 idl0r Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit python eutils

DESCRIPTION="Simple battery monitor ideal for openbox etc."
HOMEPAGE="http://code.google.com/p/batterymon/"
SRC_URI="http://batterymon.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify"

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/dbus-python
	dev-libs/dbus-glib
	dev-python/pygtk:2
	libnotify? ( dev-python/notify-python )"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${P}-import.patch"
}

src_install() {
	newbin batterymon.py batterymon || die

	insinto $(python_get_sitedir)/${PN}
	doins {logger,preferences,settings}.py || die

	# Create missing __init__.py
	touch "${D}/$(python_get_sitedir)/${PN}/__init__.py"

	# Upstream forgot an svn dir
	rm -rf icons/.svn

	insinto /usr/share/${PN}/
	doins -r icons/ batterymon.rc || die
}

pkg_postinst() {
	python_mod_optimize ${PN}

	einfo
	einfo "Your own batterymon.rc will be loaded from ~/.config/${PN}/"
	einfo "The default configuration can be found here: '${ROOT}usr/share/${PN}/${PN}.rc'"
	einfo
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
