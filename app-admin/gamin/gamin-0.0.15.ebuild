# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gamin/gamin-0.0.15.ebuild,v 1.6 2004/11/17 16:14:50 vapier Exp $

inherit eutils

DESCRIPTION="Library providing the FAM File Alteration Monitor API"
HOMEPAGE="http://www.gnome.org/~veillard/gamin/"
SRC_URI="http://www.gnome.org/~veillard/gamin/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/glib-2.0
	!app-admin/fam"
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
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README TODO
}
