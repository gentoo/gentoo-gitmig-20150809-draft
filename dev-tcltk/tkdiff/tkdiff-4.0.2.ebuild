# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkdiff/tkdiff-4.0.2.ebuild,v 1.1 2005/03/27 02:25:11 matsuu Exp $

MY_P="${PN}_${PV//./_}"
DESCRIPTION="tkdiff is a graphical front end to the diff program"
HOMEPAGE="http://tkdiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/tkdiff/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/tk-8.4"

S="${WORKDIR}/${PN}-unix"

src_install() {
	dobin tkdiff
	dodoc Changelog
}
