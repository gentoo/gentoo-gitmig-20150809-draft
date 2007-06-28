# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diasce/diasce-1.4.ebuild,v 1.12 2007/06/28 19:54:00 eva Exp $

inherit eutils

MY_P=${PN}2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The C/C++ Code editor for Gnome"
HOMEPAGE="http://diasce.sourceforge.net/"
SRC_URI="mirror://sourceforge/diasce/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
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
	>=gnome-base/orbit-2.8
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-linc.patch
}

src_compile() {
	local myconf=""

	myconf="${myconf} `use_enable nls`"

	econf ${myconf} || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
