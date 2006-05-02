# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hunspell/hunspell-1.1.4.ebuild,v 1.5 2006/05/02 06:59:09 kevquinn Exp $

inherit eutils multilib

DESCRIPTION="Hunspell spell checker - an improved replacement for myspell in OOo."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://hunspell.sourceforge.net/"

SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE="ncurses readline"
KEYWORDS="~ppc ~sparc ~x86"

DEPEND="readline? ( sys-libs/readline )
	ncurses? ( sys-libs/ncurses )
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:tail +:tail -n +:' ${S}/tests/test.sh ||\
		die "Failed to fix-up tail for POSIX compliance"
	# Upstream package creates executables 'example', 'munch'
	# and 'unmunch' which are too generic to be placed in
	# /usr/bin - this patch prefixes them with 'hunspell-'.
	# It modifies a Makefile.am file, hence autoreconf.
	epatch ${FILESDIR}/hunspell-1.1.3-renameexes.patch
	autoreconf
}

src_compile() {
	# I wanted to put the include files in /usr/include/hunspell
	# but this means the openoffice build won't find them.
	econf \
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
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	# hunspell is derived from myspell
	dodoc AUTHORS.myspell README.myspell license.myspell
}

pkg_postinst() {
	einfo "To use this package you will also need a dictionary."
	einfo "Hunspell uses myspell format dictionaries; find them"
	einfo "in the app-dicts category as myspell-<LANG>."
}
