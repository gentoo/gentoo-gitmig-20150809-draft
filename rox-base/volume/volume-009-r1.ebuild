# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/volume/volume-009-r1.ebuild,v 1.2 2007/06/30 03:09:46 lack Exp $

ROX_VER=2.1.0
ROX_LIB_VER=2.0.0
inherit rox eutils

MY_PN="Volume"
DESCRIPTION="Volume is a ROX Panel Applet that puts a popup volume control in your panel."
HOMEPAGE="http://www.hayber.us/rox/Volume"
SRC_URI="http://www.hayber.us/rox/applets/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=dev-python/pyalsaaudio-0.2"

APPNAME=${MY_PN}
APPCATEGORY="AudioVideo;Audio;Mixer"
S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-no_channels.patch
}
