# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krecipes/krecipes-0.6_beta.ebuild,v 1.1 2004/10/31 01:52:09 motaboy Exp $

inherit kde

DESCRIPTION="A KDE Recipe Tool"
HOMEPAGE="http://krecipes.sourceforge.net"
SRC_URI="mirror://sourceforge/krecipes/${PN}_beta_0.6.tar.gz"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

S="${WORKDIR}/${PN}-0.6"
IUSE="sqlite mysql"
DEPEND="sqlite? ( =dev-db/sqlite-2* )
	mysql? ( dev-db/mysql )"

need-kde 3