# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-pydev-bin/eclipse-pydev-bin-0.8.0.ebuild,v 1.2 2004/12/16 16:15:40 swegener Exp $

inherit eclipse-ext

MY_PV=${PV//\./_}

DESCRIPTION="Python Development Tools for Eclipse"
HOMEPAGE="http://http://pydev.sourceforge.net"
SRC_URI="mirror://sourceforge/pydev/pydev_${MY_PV}.zip"
SLOT="1"
LICENSE="CPL-1.0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-util/eclipse-sdk-3.0
	dev-lang/python"

S=${WORKDIR}

src_compile() {
	einfo "${P} is a binary package"
}

src_install () {
	eclipse-ext_require-slot 3 || die "Failed to find suitable Eclipse installation"

	eclipse-ext_create-ext-layout binary || die "Failed to create layout"

	eclipse-ext_install-features features/* || die "Failed to install features"
	eclipse-ext_install-plugins plugins/* || die "Failed to install plugins"
}
