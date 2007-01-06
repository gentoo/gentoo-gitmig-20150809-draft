# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.3.99.2.ebuild,v 1.3 2007/01/06 17:56:43 nichoj Exp $

inherit eutils xfce44

xfce44_beta

DESCRIPTION="Xfce 4 utilities"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc debug"

RDEPEND="|| ( x11-apps/xrdb
	virtual/x11 )
	dev-libs/dbh
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	media-libs/libpng
	~xfce-base/libxfce4util-${PV}
	~xfce-base/libxfcegui4-${PV}
	~xfce-base/libxfce4mcs-${PV}
	~xfce-base/xfce-mcs-manager-${PV}"

XFCE_CONFIG="--enable-gdm --with-vendor-info=Gentoo"

xfce44_core_package

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/nolisten-tcp.patch
}

src_install() {
	xfce44_src_install

	insinto /usr/share/xfce4/
	newins ${FILESDIR}/Gentoo Gentoo

	if use doc; then
		dodoc AUTHORS INSTALL README COPYING ChangeLog HACKING
		dodoc NEWS THANKS TODO
	fi
}
