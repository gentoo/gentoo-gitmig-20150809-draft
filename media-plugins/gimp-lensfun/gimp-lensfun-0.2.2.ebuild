# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gimp-lensfun/gimp-lensfun-0.2.2.ebuild,v 1.2 2012/09/30 13:16:41 hwoarang Exp $

EAPI="4"

MY_PN="gimplensfun"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Lensfun plugin for GIMP"
HOMEPAGE="http://lensfun.sebastiankraft.net/"
SRC_URI="http://lensfun.sebastiankraft.net/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-gfx/gimp
	media-gfx/exiv2
	media-libs/lensfun"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
        exeinto $(gimptool-2.0 --gimpplugindir)/plug-ins
        doexe ${MY_PN}
}

