# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-0.6.2.ebuild,v 1.10 2004/06/24 21:37:50 agriffis Exp $

DESCRIPTION="gnome front end to gnupg"
HOMEPAGE="http://seahorse.sourceforge.net/"
SRC_URI="mirror://sourceforge/seahorse/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

RDEPEND="virtual/x11
	>=app-crypt/gnupg-1.2.0
	=app-crypt/gpgme-0.3.14
	>=x11-libs/gtk+-2*
	>=gnome-base/libgnome-2*
	>=app-text/scrollkeeper-0.3*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README TODO THANKS
}
