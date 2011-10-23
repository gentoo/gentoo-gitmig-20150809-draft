# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dxr3/vdr-dxr3-0.2.13.ebuild,v 1.1 2011/10/23 15:58:40 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin versionator flag-o-matic

DESCRIPTION="VDR plugin: Use a dxr3 or hw+ card as output device"
HOMEPAGE="http://sourceforge.net/projects/dxr3plugin/"
SRC_URI="mirror://sourceforge/dxr3plugin/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-video/em8300-libraries
	>=media-video/vdr-1.6.0_p2-r7
	virtual/ffmpeg"
RDEPEND="${DEPEND}"

# buildtime depend
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_prepare() {
	vdr-plugin_src_prepare

	cd "${S}"
	sed -i Makefile -e 's:^FFMDIR =.*$:FFMDIR=/usr/include/ffmpeg:'

	# UINT64_C is needed by ffmpeg headers
	append-flags -D__STDC_CONSTANT_MACROS
}

src_install() {
	vdr-plugin_src_install
	emake CONFDIR="${D}/etc/vdr" install-data
}
