# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/gurlchecker/gurlchecker-0.6.7-r1.ebuild,v 1.1 2004/11/17 17:40:19 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="Gnome tool that checks links on web pages/sites"
HOMEPAGE="http://gurlchecker.labs.libre-entreprise.org/"
SRC_URI="http://labs.libre-entreprise.org/download.php/123/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

# control-center required for Edit->Preferences->Configure network proxy
RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2
	>=net-libs/gnet-2
	>=gnome-base/control-center-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING NEWS README THANKS TODO"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Avoid a potential endless loop. See bug #62408.
	epatch ${FILESDIR}/${P}-loop_fix.patch
}
