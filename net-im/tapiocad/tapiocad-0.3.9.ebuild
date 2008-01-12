# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tapiocad/tapiocad-0.3.9.ebuild,v 1.7 2008/01/12 17:17:28 coldwind Exp $

DESCRIPTION="Tapioca framework for VOIP and IM"
HOMEPAGE="http://tapioca-voip.sf.net"
SRC_URI="mirror://sourceforge/tapioca-voip/tapioca-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/dbus-glib-0.71"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/tapioca-${PV}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
