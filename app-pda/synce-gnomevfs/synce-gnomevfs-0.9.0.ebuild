# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gnomevfs/synce-gnomevfs-0.9.0.ebuild,v 1.1 2004/09/25 17:47:52 liquidx Exp $

DESCRIPTION="Synchronize Windows CE devices with Linux. GNOME Plugin for CE devices."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=app-pda/synce-libsynce-0.9.0
	>=app-pda/synce-librapi2-0.9.0
	>=gnome-base/gnome-vfs-2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
}
