# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man-db/man-db-2.6.0.2.ebuild,v 1.6 2011/06/23 20:10:25 ranger Exp $

EAPI="2"

inherit autotools-utils eutils

DESCRIPTION="a man replacement that utilizes berkdb instead of flat files"
HOMEPAGE="http://www.nongnu.org/man-db/"
SRC_URI="http://download.savannah.nongnu.org/releases/man-db/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~x86"
IUSE="berkdb +gdbm nls static-libs"

RDEPEND="
	dev-libs/libpipeline
	berkdb? ( sys-libs/db )
	gdbm? ( sys-libs/gdbm )
	!berkdb? ( !gdbm? ( sys-libs/gdbm ) )
	|| ( sys-apps/groff >=app-doc/heirloom-doctools-080407-r2 )
	!sys-apps/man
"
DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
"

pkg_setup() {
	enewgroup man 15
	enewuser man 13 -1 /usr/share/man man
}

src_prepare() {
	# bug #371937
	epatch "${FILESDIR}"/${PN}-2.6.0.2-flock.h.patch
}

src_configure() {
	local db="gdbm"
	use berkdb && ! use gdbm && db="db"
	econf \
		--with-sections="1 1p 8 2 3 3p 4 5 6 7 9 0p tcl n l p o 1x 2x 3x 4x 5x 6x 7x 8x" \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		--with-db=${db}
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README ChangeLog NEWS docs/{HACKING,TODO}
	use static-libs || remove_libtool_files
}
