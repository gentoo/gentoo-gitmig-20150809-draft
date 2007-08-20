# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/hotkeys/hotkeys-0.5.7.1-r1.ebuild,v 1.17 2007/08/20 13:40:37 ulm Exp $

inherit eutils

DESCRIPTION="Make use of extra buttons on newer keyboards."
HOMEPAGE="http://ypwong.org/hotkeys"
SRC_URI="http://ypwong.org/hotkeys/${PV}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"
IUSE="gtk xosd"

RDEPEND="x11-libs/libXmu
	x11-libs/libxkbfile
	>=dev-libs/libxml2-2.2.8
	=sys-libs/db-3.2*
	xosd? ( >=x11-libs/xosd-1 )
	gtk? ( >=x11-libs/gtk+-2 )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PF}-gentoo.diff
}

src_compile() {
	if use gtk; then
		opts="${opts} --with-gtk"
	fi
	econf \
		--disable-db3test \
		$(use_with xosd) \
		${opts}

	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS BUGS ChangeLog README TODO
}
