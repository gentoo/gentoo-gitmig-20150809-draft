# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diasce/diasce-1.4.ebuild,v 1.6 2004/07/14 23:17:45 agriffis Exp $

inherit eutils

MY_P=${PN}2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The C/C++ Code editor for Gnome"
HOMEPAGE="http://diasce.es.gnome.org/"
SRC_URI="http://diasce.es.gnome.org/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="nls"

RDEPEND=">=dev-libs/libxml2-2.4
	>=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomecanvas-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	has_version '>=ORBit2-2.8.0' && epatch ${FILESDIR}/${P}-linc.patch.tar.bz2
}

src_compile() {
	local myconf=""
	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf} || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
