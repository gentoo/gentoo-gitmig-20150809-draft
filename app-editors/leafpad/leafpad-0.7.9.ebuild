# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leafpad/leafpad-0.7.9.ebuild,v 1.3 2005/03/28 23:20:25 luckyduck Exp $

inherit eutils

DESCRIPTION="simple gtk+ text editor"
HOMEPAGE="http://tarot.freeshell.org/leafpad/"
SRC_URI="http://savannah.nongnu.org/download/leafpad/${P}.tar.gz
	mirror://gentoo/${P}-file_chooser.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.4"
DEPEND="${RDEPEND} dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${P}-file_chooser.patch
}

src_compile() {
	econf --disable-rpath `use_enable nls`
	emake
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
