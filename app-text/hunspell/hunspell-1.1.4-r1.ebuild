# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hunspell/hunspell-1.1.4-r1.ebuild,v 1.5 2006/07/06 23:47:09 squinky86 Exp $

inherit eutils multilib autotools libtool

DESCRIPTION="Hunspell spell checker - an improved replacement for myspell in OOo."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://hunspell.sourceforge.net/"

SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE="ncurses readline"
KEYWORDS="amd64 ~ppc sparc ~x86 ~x86-fbsd"

DEPEND="readline? ( sys-libs/readline )
	ncurses? ( sys-libs/ncurses )
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:tail +:tail -n +:' ${S}/tests/test.sh ||\
		die "Failed to fix-up tail for POSIX compliance"
	# Rework to use libtool, so as to get shared libraries
	# where appropriate, instead of the archive-only approach
	# taken upstream.
	epatch "${FILESDIR}/${P}-libtool.patch"
	# Upstream package creates executables 'example', 'munch'
	# and 'unmunch' which are too generic to be placed in
	# /usr/bin - this patch prefixes them with 'hunspell-'.
	# Also includes a small change for libtool.
	epatch "${FILESDIR}/${P}-renameexes.patch"

	# Makefile.am modified, libtool added, hence autoreconfi
	# and elibtoolize.
	WANT_AUTOMAKE="1.9" eautoreconf
	elibtoolize
}

src_compile() {
	# I wanted to put the include files in /usr/include/hunspell
	# but this means the openoffice build won't find them.
	econf \
		--includedir=/usr/include/hunspell \
		$(use_with readline readline) \
		$(use_with ncurses ui) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_test() {
	# One of the tests doesn't like LC_ALL being set to encodings
	# capable of expressing beta-S, so we simply clear it.
	# bug #125375
	LC_ALL="C" make check
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	# hunspell is derived from myspell
	dodoc AUTHORS.myspell README.myspell license.myspell
}

pkg_postinst() {
	einfo "To use this package you will also need a dictionary."
	einfo "Hunspell uses myspell format dictionaries; find them"
	einfo "in the app-dicts category as myspell-<LANG>."
}
