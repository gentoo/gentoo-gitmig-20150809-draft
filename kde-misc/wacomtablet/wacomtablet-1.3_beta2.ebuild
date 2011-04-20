# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/wacomtablet/wacomtablet-1.3_beta2.ebuild,v 1.1 2011/04/20 20:48:28 scarabeus Exp $

EAPI=4

MY_P=${PN}-v${PV/_/-}

inherit kde4-base

DESCRIPTION="KControl module for wacom tablets"
HOMEPAGE="http://kde-apps.org/content/show.php?action=content&content=114856"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/114856-${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	!<x11-drivers/xf86-input-wacom-0.10.11
"

S=${WORKDIR}/${MY_P}
