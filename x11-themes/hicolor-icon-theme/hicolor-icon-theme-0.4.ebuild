# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/hicolor-icon-theme/hicolor-icon-theme-0.4.ebuild,v 1.5 2004/03/26 08:27:58 mr_bones_ Exp $

DESCRIPTION="Fallback theme for freedesktop icon theme specification"
HOMEPAGE="http://freedesktop.org/Software/icon-theme"
SRC_URI="http://freedesktop.org/Software/icon-theme/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND=""

src_compile() {

	econf --prefix=${D}/usr || die

}

src_install() {

	make DESTDIR=${D} PREFIX=${D}/usr install || die

	dodoc README ChangeLog

}
