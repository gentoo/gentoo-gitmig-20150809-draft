# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxcl/nxcl-0.9.ebuild,v 1.2 2008/05/13 15:24:11 voyageur Exp $

inherit autotools

MY_P="freenx-client-${PV}"
DESCRIPTION="A library for building NX clients"
HOMEPAGE="http://developer.berlios.de/projects/freenx/"
SRC_URI="mirror://berlios/freenx/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus doc"

RDEPEND="net-misc/nx
	dbus? ( sys-apps/dbus )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"
S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf $(use_with doc doxygen) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
