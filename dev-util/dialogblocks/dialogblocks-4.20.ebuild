# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialogblocks/dialogblocks-4.20.ebuild,v 1.1 2007/12/04 14:24:21 mrness Exp $

inherit eutils

DESCRIPTION="GUI builder tool for wxWidgets"
HOMEPAGE="http://www.anthemion.co.uk/dialogblocks/"
SRC_URI="!amd64? ( http://www.anthemion.co.uk/${PN}/DialogBlocks-${PV}-i386.tar.gz )
	amd64? ( http://www.anthemion.co.uk/${PN}/DialogBlocks-${PV}-i686.tar.gz )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2" # make sure gtk+ is installed before built_with_use test
RDEPEND="${DEPEND}
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

	dosym /opt/dialogblocks/dialogblocks32x32.xpm /usr/share/pixmaps/dialogblocks.xpm
	dosym /opt/dialogblocks/dialogblocks.desktop /usr/share/applications/dialogblocks.desktop
	newbin "${FILESDIR}/dialogblocks.sh" dialogblocks
}

pkg_postinst() {
	if ! built_with_use ">=x11-libs/gtk+-2" xinerama ; then
		eerror "In order to emerge this package, you need to re-emerge"
		eerror "x11-libs/gtk+ with xinerama USE flag enabled."
	fi
}
