# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-0.6.3.ebuild,v 1.9 2004/09/24 23:46:14 pvdabeel Exp $

inherit gnome2

DESCRIPTION="gnome front end to gnupg"
HOMEPAGE="http://seahorse.sourceforge.net/"
SRC_URI="mirror://sourceforge/seahorse/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"
IUSE=""

RDEPEND="virtual/x11
	>=app-crypt/gnupg-1.2.0
	=app-crypt/gpgme-0.3.14
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2"
DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO THANKS"
