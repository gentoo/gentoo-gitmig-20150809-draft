# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gamin/gamin-0.1.2.ebuild,v 1.4 2005/07/16 10:11:47 flameeyes Exp $

inherit eutils libtool

DESCRIPTION="Library providing the FAM File Alteration Monitor API"
HOMEPAGE="http://www.gnome.org/~veillard/gamin/"
SRC_URI="http://www.gnome.org/~veillard/gamin/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390"
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
	epatch ${FILESDIR}/${P}-freebsd.patch
	# Add support for legacy inotify interface
	epatch ${FILESDIR}/${P}-inotify-legacy-backend.patch

	# Needed by above 'legacy inotify' patch
	aclocal || die "aclocal failed"
	autoheader || die "autoheader failed"
	libtoolize --automake -c -f || die "libtoolize failed"
	autoconf || die "autoconf failed"
	automake -a -c || die "automake failed"

	# Do not remove
	elibtoolize
}

src_compile() {
	econf \
		$(use_enable kernel_linux inotify) \
		$(use_enable kernel_linux inotify-legacy) \
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
		einfo "at least an inotify 0.23-6 patched kernel, gentoo-sources-2.6.12"
		einfo "provides this patch for example."
	fi
}
