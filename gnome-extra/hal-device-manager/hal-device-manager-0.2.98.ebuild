# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hal-device-manager/hal-device-manager-0.2.98.ebuild,v 1.2 2004/11/08 08:49:36 mr_bones_ Exp $

DESCRIPTION="HAL device viewer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"
SRC_URI=""

LICENSE="|| ( GPL-2 AFL-2.0 )"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND=">=sys-apps/hal-${PV}-r1
	>=dev-python/gnome-python-2.0.0-r1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}

src_install() {
	dodir /usr/bin
	dosym /usr/share/hal/device-manager/hal-device-manager /usr/bin
}
