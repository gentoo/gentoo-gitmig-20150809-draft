# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gamin/gamin-0.1.6.ebuild,v 1.2 2005/10/13 15:21:23 dang Exp $

inherit autotools eutils libtool

DESCRIPTION="Library providing the FAM File Alteration Monitor API"
HOMEPAGE="http://www.gnome.org/~veillard/gamin/"
SRC_URI="http://www.gnome.org/~veillard/gamin/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~x86"
IUSE="debug doc"

RDEPEND="virtual/libc
	>=dev-libs/glib-2
	!app-admin/fam"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PROVIDE="virtual/fam"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fixup FreeBSD support, bug #99158
#	epatch ${FILESDIR}/${PN}-0.1.3-freebsd.patch

	# Needed by above 'legacy inotify' patch
#	eautoreconf

	# Do not remove
	elibtoolize
}

src_compile() {
	econf \
		$(use_enable kernel_linux inotify) \
		$(use_enable debug) \
		$(use_enable debug debug-api) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README TODO NEWS doc/*txt
	use doc && dohtml doc/*
}

pkg_postinst() {
	if use kernel_linux; then
		einfo "It is strongly suggested you use Gamin with an inotify enabled"
		einfo "kernel for best performance. For this release of gamin you need"
		einfo "at least gentoo-sources-2.6.13 or later."
	fi
}
