# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmathview/gtkmathview-0.6.3.ebuild,v 1.3 2004/09/03 15:35:20 pvdabeel Exp $

inherit gnome2

DESCRIPTION="Rendering engine for MathML documents"
HOMEPAGE="http://helm.cs.unibo.it/mml-widget/"
SRC_URI="http://helm.cs.unibo.it/mml-widget/sources/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ppc"
IUSE="t1lib"

RDEPEND=">=x11-libs/gtk+-2.2
	>=dev-libs/gmetadom-0.1.8
	>=dev-libs/libxml2-2.0.0
	t1lib? ( =media-libs/t1lib-1* )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

G2CONF="${G2CONF} `use_with t1lib`"

DOCS="ANNOUNCEMENT AUTHORS BUGS CONTRIBUTORS ChangeLog HISTORY INSTALL NEWS README TODO"
