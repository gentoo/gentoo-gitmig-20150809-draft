# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gamin/gamin-0.0.15.ebuild,v 1.2 2004/10/20 23:34:14 vapier Exp $

inherit eutils

DESCRIPTION="Library providing the FAM File Alteration Monitor API"
HOMEPAGE="http://www.gnome.org/~veillard/gamin/"
SRC_URI="http://www.gnome.org/~veillard/gamin/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~hppa ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/glib-2.0
	!app-admin/fam"
PROVIDE="virtual/fam"

src_compile() {
	econf \
		--enable-inotify \
		--enable-debug \
		|| die
	# Enable debug for testing the runtime backend patch

	# Currently not smp safe
	emake || die "emake failed"
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog README TODO
}
