# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/etherape/etherape-0.9.7.ebuild,v 1.1 2007/04/05 15:35:27 pva Exp $

inherit eutils gnome2

DESCRIPTION="A graphical network monitor for Unix modeled after etherman"
SRC_URI="mirror://sourceforge/etherape/${P}.tar.gz"
HOMEPAGE="http://etherape.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	net-libs/libpcap
	app-text/scrollkeeper
	sys-devel/gettext"

DOCS="ABOUT-NLS AUTHORS ChangeLog FAQ NEWS OVERVIEW README* TODO"
