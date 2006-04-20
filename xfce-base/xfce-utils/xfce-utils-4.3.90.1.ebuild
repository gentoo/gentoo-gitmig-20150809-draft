# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.3.90.1.ebuild,v 1.2 2006/04/20 14:51:13 kingtaco Exp $

inherit xfce44

xfce44_beta

DESCRIPTION="Xfce 4 utilities"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND="|| ( x11-apps/xrdb
	virtual/x11 )
	dev-libs/dbh
	>=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	~xfce-base/libxfce4util-${PV}
	~xfce-base/libxfcegui4-${PV}
	media-libs/libpng
	~xfce-base/libxfce4mcs-${PV}"

XFCE_CONFIG="--enable-gdm --with-vendor-info=Gentoo"

xfce44_core_package

src_install() {
	make DESTDIR=${D} install || die

	insinto /usr/share/xfce4/
	newins ${FILESDIR}/Gentoo Gentoo

	if use doc; then
		dodoc AUTHORS INSTALL README COPYING ChangeLog HACKING
		dodoc NEWS THANKS TODO
	fi
}
