# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-1.4.0.4-r1.ebuild,v 1.14 2003/09/11 01:15:30 msterret Exp $

DESCRIPTION="gnome-applets"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc sparc"
IUSE="nls"

RDEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
	 >=gnome-base/libgtop-1.0.12-r1
	 >=gnome-base/libghttp-1.0.9-r1"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=app-text/scrollkeeper-0.2
	>=dev-util/intltool-0.11"

src_compile() {
	local myconf

	use nls || myconf="--disable-nls"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}
