# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-0.7.5.ebuild,v 1.2 2004/11/15 14:20:34 dragonheart Exp $

inherit gnome2

DESCRIPTION="gnome front end to gnupg"
HOMEPAGE="http://seahorse.sourceforge.net/"
SRC_URI="mirror://gnome/sources/seahorse/0.7/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha ~ppc64"

RDEPEND="virtual/x11
	>=app-crypt/gnupg-1.2.0
	>=app-crypt/gpgme-1.0.0
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	!ppc64? ( >=app-editors/gedit-2.8.0 )"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO THANKS"
IUSE="doc"

src_compile() {
	gnome2_src_configure
	gnome2_src_compile
}
