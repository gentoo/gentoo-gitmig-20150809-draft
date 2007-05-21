# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hunspell/hunspell-1.1.5.ebuild,v 1.2 2007/05/21 17:49:27 kevquinn Exp $

WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="1.9"

inherit eutils multilib autotools

DESCRIPTION="Hunspell spell checker - an improved replacement for myspell in OOo."
SUBREL="-3"
SRC_URI="mirror://sourceforge/${PN}/${P}${SUBREL}.tar.gz"
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
	epatch ${FILESDIR}/hunspell-1.1.5-renameexes.patch
	# Would do eautoreconf - but until bug #142787 is fixed, eautoreconf
	# isn't enough.
	libtoolize --copy --force
	autoreconf -f
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

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	# hunspell is derived from myspell
	dodoc AUTHORS.myspell README.myspell license.myspell

	# Fixup broken install results.
	# These are included by hunspell.hxx, but aren't installed by the install
	# script
	insinto /usr/include/hunspell/
	doins license.myspell license.hunspell config.h
	# These are in the wrong place.
	mv ${D}/usr/include/munch.h ${D}/usr/include/hunspell/munch.h
	mv ${D}/usr/include/unmunch.h ${D}/usr/include/hunspell/unmunch.h
}

pkg_postinst() {
	elog "To use this package you will also need a dictionary."
	elog "Hunspell uses myspell format dictionaries; find them"
	elog "in the app-dicts category as myspell-<LANG>."
}
