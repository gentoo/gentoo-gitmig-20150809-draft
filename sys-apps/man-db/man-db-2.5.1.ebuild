# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man-db/man-db-2.5.1.ebuild,v 1.1 2008/02/24 18:25:47 vapier Exp $

inherit eutils

DESCRIPTION="a man replacement that utilizes berkdb instead of flat files"
HOMEPAGE="http://www.nongnu.org/man-db/"
SRC_URI="http://download.savannah.nongnu.org/releases/man-db/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )
	sys-libs/db"
RDEPEND="sys-libs/db
	!sys-apps/man"
PROVIDE="virtual/man"

pkg_setup() {
	enewgroup man 15
	enewuser man 13 -1 /usr/share/man man
}

src_compile() {
	econf \
		--with-sections="1 1p 8 2 3 3p 4 5 6 7 9 0p tcl n l p o 1x 2x 3x 4x 5x 6x 7x 8x" \
		$(use_enable nls) \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README docs/{ChangeLog,HACKING,NEWS,TODO}
}
