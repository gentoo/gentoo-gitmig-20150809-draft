# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krecipes/krecipes-0.5_beta.ebuild,v 1.1 2004/10/30 17:10:38 carlo Exp $

inherit kde

DESCRIPTION="A KDE Recipe Tool"
HOMEPAGE="http://krecipes.sourceforge.net"
SRC_URI="mirror://sourceforge/krecipes/${PN}_beta_0.5.tar.gz"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

S="${WORKDIR}/${PN}-0.5"
IUSE="sqlite mysql"
DEPEND="sqlite? ( =dev-db/sqlite-2* )
		mysql? ( dev-db/mysql )"
need-kde 3

