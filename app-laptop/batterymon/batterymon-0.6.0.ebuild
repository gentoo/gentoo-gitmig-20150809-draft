# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/batterymon/batterymon-0.6.0.ebuild,v 1.1 2010/04/13 14:45:40 idl0r Exp $

EAPI="3"

PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit python

DESCRIPTION="Simple battery monitor ideal for openbox etc."
HOMEPAGE="http://code.google.com/p/batterymon/"
SRC_URI="http://batterymon.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pygtk:2
	dev-python/pygobject:2"

S="${WORKDIR}/${PN}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs 2 batterymon.py
}

src_install() {
	newbin batterymon.py batterymon || die

	# Upstream forgot an svn dir
	rm -rf icons/.svn icons/default/.svn

	insinto /usr/share/${PN}/
	doins -r icons/ || die
}
