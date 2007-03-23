# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialogblocks/dialogblocks-3.17.ebuild,v 1.1 2007/03/23 08:36:46 mrness Exp $

DESCRIPTION="GUI builder tool for wxWidgets"
HOMEPAGE="http://www.anthemion.co.uk/dialogblocks/"
SRC_URI="http://www.anthemion.co.uk/${PN}/DialogBlocks-${PV}-i386-gtk2-unicode.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=media-libs/libpng-1.2
	media-libs/jpeg
	>=media-libs/tiff-3
	amd64? ( app-emulation/emul-linux-x86-gtklibs )"

S="${WORKDIR}"

src_install() {
	dodir /opt/dialogblocks
	tar -xzf DialogBlocksData.tar.gz -C "${D}/opt/dialogblocks" || die "failed to extract data from tarball"

	dosym /opt/dialogblocks/dialogblocks32x32.xpm /usr/share/pixmaps/dialogblocks.xpm
	insinto /usr/share/applications
	doins "${FILESDIR}/dialogblocks.desktop"
	newbin "${FILESDIR}/dialogblocks.sh" dialogblocks
}
