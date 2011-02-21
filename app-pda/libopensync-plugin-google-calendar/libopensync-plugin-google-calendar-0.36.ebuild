# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-google-calendar/libopensync-plugin-google-calendar-0.36.ebuild,v 1.3 2011/02/21 11:11:46 dirtyepic Exp $

EAPI="3"

PYTHON_DEPEND="2:2.5"

inherit cmake-utils python

DESCRIPTION="OpenSync Google Calendar Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	dev-libs/glib:2
	dev-libs/libxml2
	dev-python/httplib2"
RDEPEND="${DEPEND}
	dev-python/pyxml"

DOCS="README"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs 2 src/google-cal-helper.py
}

src_install() {
	cmake-utils_src_install
	find "${D}" -name '*.la' -exec rm -f {} + || die
}
