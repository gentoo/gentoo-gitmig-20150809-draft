# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/crow-designer/crow-designer-2.11.1.ebuild,v 1.1 2007/09/01 13:48:18 pva Exp $

DESCRIPTION="GTK+ GUI building tool"
HOMEPAGE="http://crow-designer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/crow-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.10.0
		>=dev-libs/guiloader-2.10.0
		>=dev-libs/guiloader-c++-2.10.0
		>=dev-cpp/gtkmm-2.10.0
		>=dev-libs/dbus-glib-0.70
		x11-misc/xdg-utils"

S="${WORKDIR}"/crow-${PV}

src_compile() {
	econf || die "configuration failed"
	emake || die "compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README NEWS
}
