# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfburn/xfburn-0.3.0_pre20070824.ebuild,v 1.4 2008/01/05 11:09:58 drac Exp $

inherit xfce44

xfce44

DESCRIPTION="GTK+ based CD and DVD burning application"
HOMEPAGE="http://www.xfce.org/projects/xfburn"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug minimal"

RDEPEND=">=dev-libs/libburn-0.3
	>=dev-libs/libisofs-0.2.8
	>=xfce-extra/exo-0.3.2
	!minimal? ( >=xfce-base/thunar-${THUNAR_MASTER_VERSION} )
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

XFCE_CONFIG="${XFCE_CONFIG} --enable-final --enable-largefile --disable-dependency-tracking"

if use minimal; then
		XFCE_CONFIG="${XFCE_CONFIG} --disable-thunar-vfs"
	else
		XFCE_CONFIG="${XFCE_CONFIG} --enable-thunar-vfs"
fi

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_postinst() {
	xfce44_pkg_postinst
	elog "DVD burning support is still incomplete in this version."
}

src_unpack() {
	unpack ${A}
	if has_version ">=dev-libs/libburn-0.4.0"; then
		sed -i -e 's:libburn-1:libburn-5:g' "${S}"/configure*
	fi
}
