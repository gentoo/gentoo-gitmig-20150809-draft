# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-musepack/xmms-musepack-0.99.ebuild,v 1.1 2004/04/22 09:06:48 eradicator Exp $

inherit eutils

DESCRIPTION="XMMS plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://www.uni-jena.de/~pfk/mpp/ http://corecodec.org/projects/mpc/"
SRC_URI="http://corecodec.org/download.php/195/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="media-sound/xmms"

DOCS="ChangeLog README_mpc-plugin_english.txt README_mpc-plugin_finnish.txt README_mpc-plugin_german.txt README_mpc-plugin_korean.txt README_mpc-plugin_spanish.txt"

src_unpack() {
	unpack ${A}

	cd ${S}

	# They forgot to remove the compiled lib.
	rm -f *.so

	# Fix up the atrocious Makefile.
	epatch ${FILESDIR}/${P}-bad-makefile.patch

#	Notr needed for the plugin:
#	if (! use esd && ! use oss); then
#		eerror "You muse have either oss or esd active in your USE flags for xmms-musepack to work properly
#	fi
#
#	use esd || sed -i 's:#define USE_ESD_AUDIO:#undef USE_ESD_AUDIO:' mpp.h
#	use oss || sed -i 's:#define USE_OSS_AUDIO:#undef USE_OSS_AUDIO:' mpp.h
}

src_compile() {
	emake || die
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe ${P}.so
	dodoc ${DOCS}
}
