# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.4.3.ebuild,v 1.4 2010/06/28 05:55:53 jer Exp $

EAPI=3
inherit eutils libtool multilib

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_prepare() {
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ANNOUNCE CHANGES README TODO
	dosbin "${FILESDIR}"/libpng-1.4.x-update.sh
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libpng12.so.0
}

pkg_postinst() {
	elog
	elog "Run /usr/sbin/libpng-1.4.x-update.sh to fix libtool archives (.la)"
	elog
	preserve_old_lib_notify /usr/$(get_libdir)/libpng12.so.0
}
