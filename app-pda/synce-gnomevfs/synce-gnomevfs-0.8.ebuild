# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gnomevfs/synce-gnomevfs-0.8.ebuild,v 1.1 2003/09/02 19:40:09 liquidx Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync." 
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=app-pda/synce-libsynce-0.8
	>=app-pda/synce-librapi2-0.8
	>=gnome-base/gnome-vfs-2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
}
