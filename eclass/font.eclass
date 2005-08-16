# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/font.eclass,v 1.16 2005/08/16 06:38:04 spyderous Exp $

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

DOCS="" # Docs to install

IUSE="X"

DEPEND="X? ( virtual/x11 )
	media-libs/fontconfig"

#
# Public functions
#

font_xfont_config() {

	# create Xfont files
	if use X ; then
		einfo "Creating fonts.scale & fonts.dir ..."
		mkfontscale "${D}/usr/share/fonts/${PN}"
		mkfontdir \
			-e /usr/share/fonts/encodings \
			-e /usr/share/fonts/encodings/large \
			"${D}/usr/share/fonts/${PN}"
		if [ -e "${FONT_S}/fonts.alias" ] ; then
			doins "${FONT_S}/fonts.alias"
		fi
	fi

}

font_xft_config() {

	# create fontconfig cache
	einfo "Creating fontconfig cache ..."
	# Mac OS X has fc-cache at /usr/X11R6/bin
	HOME="/root" fc-cache -f "${D}/usr/share/fonts/${PN}"

}

#
# Public inheritable functions
#

font_src_install() {

	local suffix

	cd "${FONT_S}"

	insinto "/usr/share/fonts/${PN}"

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
	rm "/usr/share/fonts/${PN}/fonts.cache-1"

}

EXPORT_FUNCTIONS src_install pkg_setup
