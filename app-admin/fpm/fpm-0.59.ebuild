# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fpm/fpm-0.59.ebuild,v 1.7 2004/10/05 02:58:10 pvdabeel Exp $

DESCRIPTION="A password manager for gnome"
HOMEPAGE="http://fpm.sourceforge.net/"
SRC_URI="mirror://sourceforge/fpm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="nls"

DEPEND="virtual/libc
	gnome-base/gnome-libs
	>=dev-libs/libxml2-2.5.7-r2
	x11-libs/gtk+
	dev-libs/glib
	nls? ( sys-devel/gettext )"
DEPEND="${DEPEND}
	dev-util/cvs"

src_compile() {
	./autogen.sh --prefix=/usr \
	./configure --prefix=/usr
	emake || die "Make failed"
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc NEWS README ChangeLog TODO
}
