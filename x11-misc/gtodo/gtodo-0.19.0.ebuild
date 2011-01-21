# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtodo/gtodo-0.19.0.ebuild,v 1.3 2011/01/21 10:18:51 hwoarang Exp $

EAPI=2
inherit eutils
MY_P=${PN}2-${PV}

DESCRIPTION="Gnome Task List Manager is a GTK+ based TODO application."
HOMEPAGE="http://blog.sarine.nl/category/gtodo"
SRC_URI="http://download.sarine.nl/gtodo2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	gnome-base/libglade
	dev-libs/libxml2
	gnome-base/gnome-vfs
	gnome-base/libgnomeui"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	make_desktop_entry ${PN}2 GTodo /usr/share/${PN}2/${PN}.png "Office;GTK"
}
