# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/font.eclass,v 1.10 2004/10/19 19:51:12 vapier Exp $

# Author: foser <foser@gentoo.org>

# Font Eclass
#
# Eclass to make font installation more uniform

inherit eutils

ECLASS="font"
INHERITED="$INHERITED $ECLASS"

#
# Variable declarations
#

FONT_SUFFIX=""	# Space delimited list of font suffixes to install

FONT_S="${S}" # Dir containing the fonts

DOCS="" # Docs to install

IUSE="${IUSE} X"

DEPEND="${DEPEND} \
		X? ( virtual/x11 ) \
		media-libs/fontconfig"

# 
# Public functions
#

font_xfont_config() {

	# create Xfont files
	if use X ;
	then
		einfo "Creating fonts.scale & fonts.dir ..."
		mkfontscale "${D}/usr/share/fonts/${PN}"
		mkfontdir \
			-e /usr/share/fonts/encodings \
			-e /usr/share/fonts/encodings/large \
			-e /usr/X11R6/$(get_libdir)/X11/fonts/encodings \
			"${D}/usr/share/fonts/${PN}"
		if [ -e "${FONT_S}/fonts.alias" ] ;
		then
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
	for f in ${DOCS}; do
		[[ -e "${f}" ]] && dodoc "${f}"
	done
}

EXPORT_FUNCTIONS src_install
