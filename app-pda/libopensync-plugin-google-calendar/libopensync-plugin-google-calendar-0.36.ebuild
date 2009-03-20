# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-google-calendar/libopensync-plugin-google-calendar-0.36.ebuild,v 1.2 2009/03/20 12:57:32 josejx Exp $

inherit cmake-utils

DESCRIPTION="OpenSync Google Calendar Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	dev-python/httplib2"
RDEPEND="${DEPEND}
	dev-python/pyxml"
