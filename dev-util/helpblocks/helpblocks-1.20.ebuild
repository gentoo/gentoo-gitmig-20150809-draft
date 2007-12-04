# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/helpblocks/helpblocks-1.20.ebuild,v 1.1 2007/12/04 14:32:25 mrness Exp $

DESCRIPTION="HTML Help Editor for wxWidgets"
HOMEPAGE="http://www.helpblocks.com/"
SRC_URI="x86? ( http://www.helpblocks.com/HelpBlocks-${PV}-i386.tar.gz )
	amd64? ( http://www.helpblocks.com/HelpBlocks-${PV}-i686.tar.gz )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=x11-libs/gtk+-2
	>=media-libs/libpng-1.2
	media-libs/jpeg
	>=media-libs/tiff-3"

S="${WORKDIR}"

RESTRICT="strip" # the helpblocks program is already stripped

src_install() {
	dodir /opt/helpblocks
	tar -xzf HelpBlocksData.tar.gz -C "${D}/opt/helpblocks" || die "failed to extract data from tarball"

	dosym /opt/helpblocks/helpblocks.xpm /usr/share/pixmaps/helpblocks.xpm
	insinto /usr/share/applications
	doins "${FILESDIR}/helpblocks.desktop"
	newbin "${FILESDIR}/helpblocks.sh" helpblocks
}
