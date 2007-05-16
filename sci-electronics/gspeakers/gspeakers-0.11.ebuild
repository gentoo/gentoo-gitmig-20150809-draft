# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gspeakers/gspeakers-0.11.ebuild,v 1.4 2007/05/16 21:44:32 calchan Exp $

inherit gnome2

DESCRIPTION="GTK based loudspeaker enclosure and crossovernetwork designer"
HOMEPAGE="http://gspeakers.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="amd64 x86 ~ppc"
IUSE=""

DEPEND=">=dev-cpp/gtkmm-2.4
	>=sci-electronics/gnucap-0.34
	dev-libs/libxml2
	dev-util/pkgconfig"

DOCS="README* INSTALL Changelog AUTHORS NEWS ABOUT"
