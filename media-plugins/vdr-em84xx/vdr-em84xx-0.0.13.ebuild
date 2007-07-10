# Copyright 2003-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-em84xx/vdr-em84xx-0.0.13.ebuild,v 1.3 2007/07/10 23:08:59 mr_bones_ Exp $

IUSE=""
inherit vdr-plugin eutils

RESTRICT="mirror"
DESCRIPTION="VDR plugin: use em84xx as video-output-device"
HOMEPAGE="http://www.arghgra.de/"
SRC_URI="http://www.arghgra.de/${P}.tar.gz"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.36
	media-video/em84xx-libraries"
RDEPEND="${DEPEND}
	media-video/em84xx-modules"

PATCHES="${FILESDIR}/${PV}/gcc4.diff"

VDR_RCADDON_FILE="${FILESDIR}/rc-addon-0.0.13.sh"
VDR_CONFD_FILE="${FILESDIR}/confd-0.0.13"
