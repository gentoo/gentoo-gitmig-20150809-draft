# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gringotts/gringotts-0.5.9.ebuild,v 1.7 2003/02/13 06:15:12 vapier Exp $

DESCRIPTION="Gringotts is a utility that allows you to jot down sensitive data"
SRC_URI="http://devel.pluto.linux.it/projects/Gringotts/current/${P}.tar.bz2"
HOMEPAGE="http://devel.pluto.linux.it/projects/Gringotts/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

RDEPEND=">=dev-libs/glib-2.0.3
	>=dev-libs/atk-1.0.2 
	>=x11-libs/pango-1.0.2
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/libmcrypt-2.4.19-r1
	>=app-crypt/mhash-0.8.16"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	econf
	emake || die
}
 
src_install() {
	make DESTDIR=${D} install || die

	dodoc COPYING ChangeLog README AUTHORS
}
