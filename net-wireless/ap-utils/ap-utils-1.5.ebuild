# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ap-utils/ap-utils-1.5.ebuild,v 1.1 2009/09/05 17:52:54 patrick Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="Wireless Access Point Utilities for Unix"
HOMEPAGE="http://ap-utils.polesye.net/"
SRC_URI="ftp://linux.zhitomir.net/ap-utils/ap-utils-1.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND=">=sys-devel/bison-1.34"
RDEPEND=""

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install () {
	emake DESTDIR="${D}" install || die "Installation failed."
	dodoc ChangeLog NEWS README THANKS TODO
}
