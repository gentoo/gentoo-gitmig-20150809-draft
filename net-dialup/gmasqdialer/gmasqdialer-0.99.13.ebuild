# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gmasqdialer/gmasqdialer-0.99.13.ebuild,v 1.4 2004/07/01 22:06:37 eradicator Exp $

DESCRIPTION="GMasqdialer - A GNOME Client for MasqDialer"
HOMEPAGE="http://www.dpinson.com/software/gmasqdialer/index.php"
SRC_URI="http://www.dpinson.com/software/gmasqdialer/files/${P}.tar.gz"

LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86"
SLOT="0"

DEPEND="virtual/libc
	>=x11-libs/gtk+-2.0"

src_compile() {

	econf || die "econf failed."
	emake || die "parallel make failed."

}

src_install() {

	einstall || die "install failed."
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

}
