# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-1.4.0.5.ebuild,v 1.16 2006/02/25 01:53:29 allanonjl Exp $

DESCRIPTION="Applets for the Gnome1 Desktop and Panel"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 hppa ~ia64 ppc sparc x86"
IUSE="nls"

RDEPEND="<gnome-base/gnome-panel-1.5.0
	=gnome-base/libgtop-1.0*
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
		--includedir="" \
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
