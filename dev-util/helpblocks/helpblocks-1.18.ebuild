# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/helpblocks/helpblocks-1.18.ebuild,v 1.1 2006/08/18 13:58:01 mrness Exp $

DESCRIPTION="HTML Help Editor for wxWidgets"
HOMEPAGE="http://www.helpblocks.com/"
SRC_URI="http://www.helpblocks.com/HelpBlocks-${PV}-i386-gtk2-unicode-suse92.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=media-libs/libpng-1.2
	media-libs/jpeg
	>=media-libs/tiff-3"

S="${WORKDIR}"

src_install() {
	dodir /opt/helpblocks
	tar -xzf HelpBlocksData.tar.gz -C "${D}/opt/helpblocks" || die "failed to extract data from tarball"

	dosym /opt/helpblocks/helpblocks.xpm /usr/share/pixmaps/helpblocks.xpm
	insinto /usr/share/applications
	doins "${FILESDIR}/helpblocks.desktop"
	newbin "${FILESDIR}/helpblocks.sh" helpblocks
}
