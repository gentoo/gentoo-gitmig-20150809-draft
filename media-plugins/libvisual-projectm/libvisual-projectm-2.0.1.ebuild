# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libvisual-projectm/libvisual-projectm-2.0.1.ebuild,v 1.1 2009/12/10 20:00:12 ssuominen Exp $

inherit cmake-utils

MY_P=projectM_libvisual-${PV}-Source

DESCRIPTION="A libvisual graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="media-libs/libsdl
	=media-libs/libvisual-0.4*
	>=media-libs/libprojectm-2.0.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS ChangeLog"
