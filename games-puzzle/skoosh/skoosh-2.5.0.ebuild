# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/skoosh/skoosh-2.5.0.ebuild,v 1.2 2004/11/05 05:11:28 josejx Exp $

inherit gnome2

DESCRIPTION="Sliding tile puzzle for Gnome 2"
HOMEPAGE="http://homepages.ihug.co.nz/~trmusson/programs.html"
SRC_URI="http://homepages.ihug.co.nz/~trmusson/stuff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="nls"

DEPEND=">=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	# Need to apply omf fix or else we get access
	# violation errors related to sandbox.
	gnome2_omf_fix "${S}/help/C/Makefile.in"
}
