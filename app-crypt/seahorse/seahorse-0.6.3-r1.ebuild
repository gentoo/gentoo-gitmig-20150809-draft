# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-0.6.3-r1.ebuild,v 1.7 2004/10/31 15:27:12 tgall Exp $

inherit gnome2

DESCRIPTION="gnome front end to gnupg"
HOMEPAGE="http://seahorse.sourceforge.net/"
SRC_URI="mirror://sourceforge/seahorse/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64 ~alpha ppc64"

RDEPEND="virtual/x11
	>=app-crypt/gnupg-1.2.0
	=app-crypt/gpgme-0.3.14-r1
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO THANKS"

src_compile() {
	export GPGME_CONFIG=${ROOT}/usr/bin/gpgme3-config
	gnome2_src_configure
	gnome2_src_compile
}
