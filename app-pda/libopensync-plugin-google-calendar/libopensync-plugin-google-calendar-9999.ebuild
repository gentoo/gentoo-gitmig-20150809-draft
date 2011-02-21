# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-google-calendar/libopensync-plugin-google-calendar-9999.ebuild,v 1.2 2011/02/21 11:11:46 dirtyepic Exp $

EAPI="3"

inherit cmake-utils subversion

DESCRIPTION="OpenSync Google Calendar Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/plugins/google-calendar"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	dev-libs/glib:2
	dev-libs/libxml2
	dev-libs/libxslt
	>=net-libs/libgcal-0.9.6"
RDEPEND="${DEPEND}"

DOCS="AUTHORS README"

src_install() {
	cmake-utils_src_install
	find "${D}" -name '*.la' -exec rm -f {} + || die
}
