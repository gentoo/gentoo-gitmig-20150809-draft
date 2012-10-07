# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kolor-manager/kolor-manager-0.9.5_p20121007.ebuild,v 1.1 2012/10/07 14:00:24 creffett Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KControl module for Oyranos CMS cross desktop settings."
HOMEPAGE="http://www.oyranos.org/wiki/index.php?title=Kolor-manager"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=media-libs/oyranos-0.4.0
	media-libs/libXcm
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"

#S=${WORKDIR}
