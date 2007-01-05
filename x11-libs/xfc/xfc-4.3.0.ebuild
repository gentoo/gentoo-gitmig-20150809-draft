# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xfc/xfc-4.3.0.ebuild,v 1.2 2007/01/05 04:53:46 flameeyes Exp $

DESCRIPTION="C++ bindings for gtk+ related to Xfce"
HOMEPAGE="http://xfc.xfce.org"
SRC_URI="http://xfc.xfce.org/download/${PV}/src/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc debug"

RDEPEND=">=dev-libs/glib-2.4.0
	>=dev-libs/libsigc++-2.0.0
	>=dev-libs/atk-1.6.0
	>=x11-libs/pango-1.4.0
	>=x11-libs/gtk+-2.4.0
	doc? ( >=app-doc/doxygen-1.3.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"


src_compile() {
	local myconf
	myconf=""

	if ! use doc; then
		myconf="${myconf} \
			--disable-demos \
			--disable-docs \
			--disable-examples"
	fi

	if ! use debug; then
		myconf="${myconf} \
			--disable-debug \
			--disable-tests"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
