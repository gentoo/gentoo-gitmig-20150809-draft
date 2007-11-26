# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-google-calendar/libopensync-plugin-google-calendar-9999.ebuild,v 1.1 2007/11/26 20:16:44 peper Exp $

inherit cmake-utils subversion

DESCRIPTION="OpenSync Google Calendar Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/plugins/google-calendar"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	dev-python/httplib2"
RDEPEND="${DEPEND}
	dev-python/pyxml"
