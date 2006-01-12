# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/font.eclass,v 1.18 2006/01/12 04:42:13 robbat2 Exp $

# Author: foser <foser@gentoo.org>

# Font Eclass
#
# Eclass to make font installation more uniform

inherit eutils


#
# Variable declarations
#

FONT_SUFFIX=""	# Space delimited list of font suffixes to install

FONT_S="${S}" # Dir containing the fonts

FONT_PN="${PN}" # Last part of $FONTDIR

FONTDIR="/usr/share/fonts/${FONT_PN}" # this is where the fonts are installed

DOCS="" # Docs to install

IUSE="X"

DEPEND="X? ( || ( x11-apps/mkfontdir virtual/x11 ) )
		media-libs/fontconfig"

#
# Public functions
#

font_xfont_config() {

	# create Xfont files
	if use X ; then
		einfo "Creating fonts.scale & fonts.dir ..."
		mkfontscale "${D}${FONTDIR}"
		mkfontdir \
			-e /usr/share/fonts/encodings \
			-e /usr/share/fonts/encodings/large \
			"${D}${FONTDIR}"
		if [ -e "${FONT_S}/fonts.alias" ] ; then
			doins "${FONT_S}/fonts.alias"
		fi
	fi

}

font_xft_config() {

	# create fontconfig cache
	einfo "Creating fontconfig cache ..."
	# Mac OS X has fc-cache at /usr/X11R6/bin
	HOME="/root" fc-cache -f "${D}${FONTDIR}"

}

#
# Public inheritable functions
#

font_src_install() {

	local suffix

	cd "${FONT_S}"

	insinto "${FONTDIR}"

	for suffix in ${FONT_SUFFIX}; do
		doins *.${suffix}
	done

	rm -f fonts.{dir,scale} encodings.dir

	font_xfont_config
	font_xft_config

	cd "${S}"
	# try to install some common docs
	DOCS="${DOCS} COPYRIGHT README NEWS"
	dodoc ${DOCS}

}

font_pkg_setup() {
	# make sure we get no colissions
	# setup is not the nicest place, but preinst doesn't cut it
	rm -f "${FONTDIR}/fonts.cache-1"
}

EXPORT_FUNCTIONS src_install pkg_setup
