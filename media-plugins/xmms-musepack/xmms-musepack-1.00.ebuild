# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-musepack/xmms-musepack-1.00.ebuild,v 1.2 2004/09/03 08:15:01 eradicator Exp $

inherit eutils

DESCRIPTION="XMMS plugin to play audio files encoded with Andree Buschmann's encoder Musepack (mpc, mp+, mpp)"
HOMEPAGE="http://sourceforge.net/projects/mpegplus"
SRC_URI="mirror://sourceforge/mpegplus/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc: 1.00: error window about not being able to decode the file
KEYWORDS="x86 ~ppc amd64 -sparc"
IUSE=""

DEPEND="media-sound/xmms"

DOCS="ChangeLog README_mpc-plugin_english.txt README_mpc-plugin_finnish.txt README_mpc-plugin_german.txt README_mpc-plugin_korean.txt README_mpc-plugin_spanish.txt"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Fix up the atrocious Makefile.
	epatch ${FILESDIR}/${P}-bad-makefile.patch

#	Not needed for the plugin:
#	if (! use esd && ! use oss); then
#		eerror "You muse have either oss or esd active in your USE flags for xmms-musepack to work properly
#	fi
#
#	use esd || sed -i 's:#define USE_ESD_AUDIO:#undef USE_ESD_AUDIO:' mpp.h
#	use oss || sed -i 's:#define USE_OSS_AUDIO:#undef USE_OSS_AUDIO:' mpp.h

	# Actually, it looks for esd.h which is stupid because this is an input plugin.
	# See bug #40970
	sed -i -e 's:#define USE_ESD_AUDIO:#undef USE_ESD_AUDIO:' \
	       -e 's:#define USE_OSS_AUDIO:#undef USE_OSS_AUDIO:' mpp.h
}

src_compile() {
	emake || die
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe ${P}.so
	dodoc ${DOCS}
}
