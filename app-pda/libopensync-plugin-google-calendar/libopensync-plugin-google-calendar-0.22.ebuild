# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-google-calendar/libopensync-plugin-google-calendar-0.22.ebuild,v 1.2 2011/02/21 11:11:46 dirtyepic Exp $

EAPI="3"

PYTHON_DEPEND="2:2.5"

inherit eutils python

DESCRIPTION="OpenSync Google Calendar Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	dev-python/httplib2"
RDEPEND="${DEPEND}
	dev-python/pyxml"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-recurrent.patch
	python_convert_shebangs 2 src/google-cal-helper.py
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
	find "${D}" -name '*.la' -exec rm -f {} + || die
}
