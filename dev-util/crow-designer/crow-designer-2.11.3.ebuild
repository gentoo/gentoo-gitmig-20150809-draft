# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/crow-designer/crow-designer-2.11.3.ebuild,v 1.1 2008/04/19 20:05:08 pva Exp $

inherit eutils

DESCRIPTION="GTK+ GUI building tool"
HOMEPAGE="http://crow-designer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/crow-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-libs/guiloader-2.12
		>=dev-libs/guiloader-c++-2.12
		>=dev-libs/dbus-glib-0.74
		x11-misc/xdg-utils"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

S=${WORKDIR}/crow-${PV}

pkg_setup() {
	built_with_use dev-cpp/gtkmm accessibility || die \
		"${PN} requires dev-cpp/gtkmm built with accessibility USE flag."
}

src_compile() {
	econf || die "configuration failed"
	emake || die "compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README NEWS
}
