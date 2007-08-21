# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/hotkeys/hotkeys-0.5.7.4.0.1.ebuild,v 1.1 2007/08/21 14:01:53 ulm Exp $

inherit eutils versionator

MY_PV=$(get_version_component_range 1-4)
MY_DIST_PV=$(replace_version_separator 4 '-')
DESCRIPTION="A hotkeys daemon for your Internet/multimedia keyboard in X"
HOMEPAGE="http://packages.debian.org/unstable/x11/hotkeys"
SRC_URI="mirror://debian/pool/main/h/${PN}/${PN}_${MY_DIST_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE="gtk xosd"

RDEPEND="x11-libs/libXmu
	x11-libs/libxkbfile
	>=dev-libs/libxml2-2.2.8
	>=sys-libs/db-4.3.29-r2
	xosd? ( >=x11-libs/xosd-1 )
	gtk? ( >=x11-libs/gtk+-2 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}/${P}-audacious.patch"
}

src_compile() {
	# use_with gtk doesn't work for USE=-gtk
	econf \
		$(useq gtk && echo "--with-gtk") \
		$(use_with xosd) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS BUGS ChangeLog README TODO || die "dodoc failed"
}
