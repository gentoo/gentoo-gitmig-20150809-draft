# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aalib/aalib-1.4_rc4-r2.ebuild,v 1.18 2004/02/18 12:14:39 mholzer Exp $

inherit eutils libtool

MY_P="${P/_/}"
S="${WORKDIR}/${PN}-1.4.0"
DESCRIPTION="A ASCII-Graphics Library"
HOMEPAGE="http://aa-project.sourceforge.net/aalib/"
SRC_URI="mirror://sourceforge/aa-project/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"
IUSE="X slang gpm"

RDEPEND=">=sys-libs/ncurses-5.1
	X? ( virtual/x11 )
	gpm? ( sys-libs/gpm )
	slang? ( >=sys-libs/slang-1.4.2 )"

DEPEND="$RDEPEND >=sys-devel/autoconf-2.58"

pkg_setup() {
	# We need autoconf-2.5
	export WANT_AUTOCONF=2.5
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
	touch *
}

src_compile() {
	local myconf=""
	use slang \
		&& myconf="--with-slang-driver=yes" \
		|| myconf="--with-slang-driver=no"

	use X \
		&& myconf="${myconf} --with-x11-driver=yes" \
		|| myconf="${myconf} --with-x11-driver=no"

	use gpm \
		&& myconf="${myconf} --with-gpm-mouse=no"

	elibtoolize

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ANNOUNCE AUTHORS ChangeLog COPYING NEWS README*
}
