# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gamin/gamin-0.0.26-r6.ebuild,v 1.1 2005/04/02 22:49:57 dsd Exp $

inherit eutils

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
	# patch to work with inotify 0.21
	epatch ${FILESDIR}/${P}-inotify_use_fd.patch

}

src_compile() {

	econf \
		--enable-inotify \
		`use_enable debug` \
		`use_enable debug debug-api` \
		|| die

	emake || die "emake failed"

}

src_install() {

	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README TODO NEWS doc/*txt

	use doc && dohtml doc/*

}

pkg_postinst() {

	einfo "It is strongly suggested you use Gamin with an inotify enabled"
	einfo "kernel for best performance. For this release of gamin you need"
	einfo "at least an inotify-0.21 patched kernel."

}
