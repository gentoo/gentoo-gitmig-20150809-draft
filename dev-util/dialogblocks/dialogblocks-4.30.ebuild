# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialogblocks/dialogblocks-4.30.ebuild,v 1.1 2009/05/09 12:02:27 mrness Exp $

inherit eutils

DESCRIPTION="GUI builder tool for wxWidgets"
HOMEPAGE="http://www.anthemion.co.uk/dialogblocks/"
SRC_URI="!amd64? ( http://www.anthemion.co.uk/${PN}/DialogBlocks-${PV}-i386.tar.gz )
	amd64? ( http://www.anthemion.co.uk/${PN}/DialogBlocks-${PV}-x86_64.tar.gz )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="app-arch/tar"
RDEPEND=">=x11-libs/gtk+-2
	x11-libs/libXinerama
	>=media-libs/libpng-1.2
	media-libs/jpeg
	>=media-libs/tiff-3"

S="${WORKDIR}"

RESTRICT="strip" # the dialogblocks program is already stripped

src_install() {
	dodir /opt/dialogblocks
	tar -xzf DialogBlocksData.tar.gz -C "${D}/opt/dialogblocks" || die "failed to extract data from tarball"
	fowners -R root:root /opt/dialogblocks
	dosed 's:/usr/share/:/opt/:' /opt/dialogblocks/dialogblocks.desktop

	local i
	dosym /opt/dialogblocks/dialogblocks32x32.xpm /usr/share/pixmaps/dialogblocks.xpm
	for i in 32x32 48x48 128x128; do
	    dosym /opt/dialogblocks/appicons/dialogblocks${i}.png /usr/share/icons/hicolor/${i}/apps/dialogblocks.png
	done
	dosym /opt/dialogblocks/dialogblocks.desktop /usr/share/applications/dialogblocks.desktop
	newbin "${FILESDIR}/dialogblocks.sh" dialogblocks
}
