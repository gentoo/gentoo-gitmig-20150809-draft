# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.4.3.ebuild,v 1.6 2010/06/30 17:12:15 darkside Exp $

EAPI=3
inherit eutils libtool multilib prefix

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_prepare() {
	cp "${FILESDIR}"/libpng-1.4.x-update.sh "${T}"
	eprefixify "${T}"/libpng-1.4.x-update.sh
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ANNOUNCE CHANGES README TODO
	dosbin "${T}"/libpng-1.4.x-update.sh
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libpng12.so.0
}

pkg_postinst() {
	elog
	elog "Run ${EPREFIX}/usr/sbin/libpng-1.4.x-update.sh to fix libtool archives (.la)"
	elog
	preserve_old_lib_notify /usr/$(get_libdir)/libpng12.so.0
}
