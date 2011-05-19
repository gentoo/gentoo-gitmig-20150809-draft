# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gigolo/gigolo-0.4.1.ebuild,v 1.5 2011/05/19 22:23:37 ssuominen Exp $

EAPI=4
EAUTORECONF=yes
EINTLTOOLIZE=yes
inherit xfconf

DESCRIPTION="a frontend to easily manage connections to remote filesystems using
GIO/GVfs"
HOMEPAGE="http://www.uvena.de/gigolo/index.html http://goodies.xfce.org/projects/applications/gigolo"
SRC_URI="mirror://xfce/src/apps/${PN}/0.4/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12:2
	>=dev-libs/glib-2.16:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}

src_install() {
	xfconf_src_install
	rm -rf "${D}"/usr/share/doc/${PN}
}
