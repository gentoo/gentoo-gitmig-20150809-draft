# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fpm/fpm-0.60.ebuild,v 1.10 2006/02/16 23:31:05 flameeyes Exp $

DESCRIPTION="A password manager for gnome"
HOMEPAGE="http://fpm.sourceforge.net"
SRC_URI="mirror://sourceforge/fpm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE="nls"

DEPEND="gnome-base/gnome-libs
	>=dev-libs/libxml2-2.5.7-r2
	x11-libs/gtk+
	dev-libs/glib
	nls? ( virtual/libintl )"

RDEPEND="${DEPEND}
	dev-util/cvs"

DEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	./configure --prefix=/usr
	emake || die "Make failed"
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc NEWS README ChangeLog TODO
}
