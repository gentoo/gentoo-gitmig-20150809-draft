# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/camerakit/camerakit-0.0.1.20041011.ebuild,v 1.4 2007/08/22 16:49:21 angelos Exp $

inherit gnustep

S=${WORKDIR}/${PN/camerak/CameraK}

DESCRIPTION="A simple wrapper to libgphoto2 for GNUstep."
HOMEPAGE="http://home.gna.org/gsimageapps/"
SRC_URI="http://download.gna.org/gsimageapps/${PN/camerak/CameraK}-${PV/0.0.1.}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	>=media-libs/libgphoto2-2.1.3-r1"
RDEPEND="${GS_RDEPEND}
	>=media-libs/libgphoto2-2.1.3-r1"

egnustep_install_domain "System"
