# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aalib/aalib-1.4_rc4-r2.ebuild,v 1.24 2004/10/05 09:32:17 eradicator Exp $

IUSE="X slang gpm static"

inherit eutils libtool

MY_P="${P/_/}"
S="${WORKDIR}/${PN}-1.4.0"

DESCRIPTION="A ASCII-Graphics Library"
HOMEPAGE="http://aa-project.sourceforge.net/aalib/"
SRC_URI="mirror://sourceforge/aa-project/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips ppc64"

RDEPEND=">=sys-libs/ncurses-5.1
	X? ( virtual/x11 )
	gpm? ( sys-libs/gpm )
	slang? ( >=sys-libs/slang-1.4.2 )"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.4"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff

	elibtoolize

	touch *
}

src_compile() {
	# We need autoconf-2.5 and automake-1.4
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.4

	econf	`use_with slang slang-driver` \
		`use_with X x11-driver` \
		`use_enable static`

	emake || die
}

src_install() {
#	einstall || die
	make DESTDIR="${D}" install || die
	dodoc ANNOUNCE AUTHORS ChangeLog COPYING NEWS README*
}
