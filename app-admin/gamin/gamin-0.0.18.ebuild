# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gamin/gamin-0.0.18.ebuild,v 1.1 2004/11/30 11:42:46 foser Exp $

inherit eutils

DESCRIPTION="Library providing the FAM File Alteration Monitor API"
HOMEPAGE="http://www.gnome.org/~veillard/gamin/"
SRC_URI="http://www.gnome.org/~veillard/gamin/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390"
IUSE=""

RDEPEND="virtual/libc
	>=dev-libs/glib-2
	!app-admin/fam"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PROVIDE="virtual/fam"

src_compile() {

	# Enable debug for testing the runtime backend patch
	econf \
		--enable-inotify \
		--enable-debug \
		|| die

	emake || die "emake failed"

}

src_install() {

	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README TODO

}
