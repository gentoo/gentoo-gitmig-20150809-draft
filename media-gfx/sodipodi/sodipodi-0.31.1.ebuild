# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sodipodi/sodipodi-0.31.1.ebuild,v 1.1 2003/03/28 07:42:06 hanno Exp $

DESCRIPTION="Sodipodi is a vector-based drawing program for GNOME."
HOMEPAGE="http://sodipodi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )
	>=x11-libs/gtk+-2.2.1
	>=media-libs/libart_lgpl-2.3.11
	>=dev-libs/libxml2-2.5.1
	>=x11-libs/xft-2.0.1
	>=gnome-base/libgnomeprint-2.2.1.1
	>=gnome-base/libgnomeprintui-2.2.1.1
	>=dev-libs/popt-1.7"

src_compile() {
	use nls || myconf="--disable-nls ${myconf}"
	# breaks with gnome-print
	myconf="${myconf} --with-popt --with-xft --without-gnome-print"
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog HACKING NEWS README TODO
}
