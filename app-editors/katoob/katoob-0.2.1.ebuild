# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/katoob/katoob-0.2.1.ebuild,v 1.6 2004/04/25 22:03:20 agriffis Exp $

DESCRIPTION="Small text editor based on the GTK+ library 2.0"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=katoob"
SRC_URI="mirror://sourceforge/arabeyes/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2
	>=dev-util/pkgconfig-0.12"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""
	use nls || myconf="--disable-nls"
	econf ${myconf} || die "econf failed"
	emake || die "Compilation failed"
}

src_install() {
	einstall
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING NEWS README THANKS TODO
}
