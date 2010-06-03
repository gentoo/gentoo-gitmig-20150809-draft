# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qsynergy/qsynergy-0.9.1.ebuild,v 1.1 2010/06/03 19:57:42 wired Exp $

EAPI=3

inherit qt4-r2

DESCRIPTION="A comprehensive and easy to use graphical front end for Synergy."
HOMEPAGE="http://www.volker-lanz.de/en/software/qsynergy/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	|| ( x11-misc/synergy-plus x11-misc/synergy )"
