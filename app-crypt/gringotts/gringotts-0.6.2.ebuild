# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gringotts/gringotts-0.6.2.ebuild,v 1.1 2002/08/20 18:57:09 stroke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gringotts is a utility that allows you to jot down sensitive data"
SRC_URI="http://devel.pluto.linux.it/projects/Gringotts/current/${P}.tar.bz2"
HOMEPAGE="http://devel.pluto.linux.it/projects/Gringotts/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=dev-libs/glib-2.0.6-r1
	>=x11-libs/gtk+-2.0.6-r1
	>=dev-libs/libmcrypt-2.5.1
	>=app-crypt/mhash-0.8.16"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	econf || die

	emake || die
}
 
src_install() {
	make DESTDIR=${D} install || die

	dodoc COPYING ChangeLog README AUTHORS
}
