# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/clashscore-db/clashscore-db-3.17.ebuild,v 1.1 2010/07/22 07:05:36 jlec Exp $

# inherit

DESCRIPTION="Clashscore-db for clashlist"
HOMEPAGE="http://kinemage.biochem.duke.edu/"
SRC_URI="mirror://gentoo/molprobity-${PV}.tgz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="richardson"
IUSE=""

src_install() {
	insinto /usr/share/clashscore
	doins molprobity3/lib/clashscore.db.tab || die
}
