# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fpm/fpm-0.59.ebuild,v 1.3 2003/12/30 00:57:21 zul Exp $

DESCRIPTION="A password manager for gnome."
SRC_URI="mirror://sourceforge/fpm/${P}.tar.gz"
HOMEPAGE="http://fpm.sourceforge.net"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

DEPEND="virtual/glibc
		gnome-base/gnome-libs
		>=dev-libs/libxml2-2.5.7-r2
		x11-libs/gtk+
		dev-libs/glib
		nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}
		dev-util/cvs"

S="${WORKDIR}/${P}"

src_compile() {
	./autogen.sh --prefix=/usr \
	./configure --prefix=/usr
	emake || die "Make failed"
}

src_install() {
	make prefix=${D}/usr install
	dodoc NEWS README ChangeLog TODO
}
