# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-musepack/xmms-musepack-0.98-r2.ebuild,v 1.3 2004/03/29 23:33:40 dholm Exp $

inherit flag-o-matic eutils

# Enabling -mfpath=sse can cause high-pitched whine, at least on Pentiums.
# This drops the entire flag for safety. Reports of success with any variations
# would be welcomed, but mind those eardrums!
# This seems to be fixed for the 0.98 release (see bug #32327)
# filter-mfpmath "sse"

DESCRIPTION="XMMS plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://sourceforge.net/projects/mpegplus/ http://www.personal.uni-jena.de/~pfk/MPP/index2.html"
SRC_URI="http://www.personal.uni-jena.de/~pfk/MPP/src/xmms-${PV}.zip"
#SRC_URI="mirror://sourceforge/mpegplus/${P}.tar.bz2"

RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="esd"

RDEPEND="media-sound/xmms
	esd? ( media-sound/esound )"

DEPEND="${RDEPEND}
	sys-apps/sed"

DOCS="ChangeLog README_mpc-plugin_english.txt README_mpc-plugin_finnish.txt README_mpc-plugin_german.txt README_mpc-plugin_korean.txt README_mpc-plugin_spanish.txt"

src_unpack() {
	mkdir ${S}
	cd ${S}

	unpack ${A}
	# Fix up the atrocious Makefile.
	epatch ${FILESDIR}/${P}-bad-makefile.patch
	epatch ${FILESDIR}/${P}-titles.patch

	if ! use esd; then
		sed -i 's:#define USE_ESD_AUDIO:#undef USE_ESD_AUDIO:' mpp.h
	fi
}

src_compile() {
	# Makefile will use ARCH when calling gcc
	emake ARCH="${CFLAGS}" || die
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe ${P}.so
	dodoc ${DOCS}
}
