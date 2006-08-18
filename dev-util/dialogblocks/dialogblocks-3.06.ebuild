# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialogblocks/dialogblocks-3.06.ebuild,v 1.1 2006/08/18 13:35:54 mrness Exp $

DESCRIPTION="GUI builder tool for wxWidgets"
HOMEPAGE="http://www.anthemion.co.uk/dialogblocks/"
SRC_URI="http://www.anthemion.co.uk/${PN}/DialogBlocks-${PV}-i386-gtk2-unicode-suse92.tar.gz"

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
	dodir /opt/dialogblocks
	tar -xzf DialogBlocksData.tar.gz -C "${D}/opt/dialogblocks" || die "failed to extract data from tarball"

	dosym /opt/dialogblocks/dialogblocks32x32.xpm /usr/share/pixmaps/dialogblocks.xpm
	insinto /usr/share/applications
	doins "${FILESDIR}/dialogblocks.desktop"
	newbin "${FILESDIR}/dialogblocks.sh" dialogblocks
}
