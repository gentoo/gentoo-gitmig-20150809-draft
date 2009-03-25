# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/crow-designer/crow-designer-2.13.0.ebuild,v 1.2 2009/03/25 09:55:06 remi Exp $

EAPI="2"
inherit eutils

DESCRIPTION="GTK+ GUI building tool"
HOMEPAGE="http://crow-designer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/crow-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/guiloader-2.13.1
		>=dev-libs/guiloader-c++-2.13
		dev-cpp/gtkmm
		>=dev-libs/dbus-glib-0.76
		x11-misc/xdg-utils"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

S=${WORKDIR}/crow-${PV}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README NEWS
}
