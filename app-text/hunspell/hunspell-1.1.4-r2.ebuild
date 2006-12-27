# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hunspell/hunspell-1.1.4-r2.ebuild,v 1.2 2006/12/27 03:57:16 tgall Exp $

inherit fixheadtails eutils multilib autotools

DESCRIPTION="Hunspell spell checker - an improved replacement for myspell in OOo"
HOMEPAGE="http://hunspell.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE="ncurses nls readline"

RDEPEND="readline? ( sys-libs/readline )
	ncurses? ( sys-libs/ncurses )
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	ht_fix_file tests/test.sh
	# Rework to use libtool, so as to get shared libraries
	# where appropriate, instead of the archive-only approach
	# taken upstream.
	epatch "${FILESDIR}"/${P}-libtool.patch
	# Upstream package creates executables 'example', 'munch'
	# and 'unmunch' which are too generic to be placed in
	# /usr/bin - this patch prefixes them with 'hunspell-'.
	# Also includes a small change for libtool.
	epatch "${FILESDIR}"/${P}-renameexes.patch
	# Don't install the munch.h and unmunch.h files, they are not
	# descriptions of exported functions.
	sed -i -e 's:include_HEADERS:noinst_HEADERS:' "${S}"/src/tools/Makefile.am

	# Recalculate the mkinstalldirs stuff (see bug #142565)
	epatch "${FILESDIR}"/${P}-gettext.patch
	# Set AT_M4DIR to workaround eautoreconf limitation (see bug #142565)
	export AT_M4DIR="${S}/m4"
	# Makefile.am modified, libtool added, hence autoreconf
	WANT_AUTOMAKE="1.9" eautoreconf
}

src_compile() {
	# I wanted to put the include files in /usr/include/hunspell
	# but this means the openoffice build won't find them.
	econf \
		--includedir=/usr/include/hunspell \
		$(use_enable readline) \
		$(use_with ncurses ui) \
		$(use_enable nls) \
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
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	# hunspell is derived from myspell
	dodoc AUTHORS.myspell README.myspell license.myspell
}

pkg_postinst() {
	einfo "To use this package you will also need a dictionary."
	einfo "Hunspell uses myspell format dictionaries; find them"
	einfo "in the app-dicts category as myspell-<LANG>."
}
