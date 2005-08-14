# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/x-modular.eclass,v 1.3 2005/08/14 23:04:02 spyderous Exp $
#
# Author: Donnie Berkholz <spyderous@gentoo.org>
#
# This eclass is designed to reduce code duplication in the modularized X11
# ebuilds.
#
# If the ebuild installs fonts, set FONT="yes" at the top and set FONT_DIRS to
# the subdirectories within /usr/share/fonts to which it installs fonts.

EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_postinst

inherit eutils

# Directory prefix to use for everything
# Change to /usr/X11R6 once it's standard
XDIR="/usr"

IUSE=""
HOMEPAGE="http://xorg.freedesktop.org/"
SRC_URI="http://xorg.freedesktop.org/X11R7.0-RC0/everything/${P}.tar.bz2"
LICENSE="X11"
SLOT="0"

# Set up shared dependencies
if [ -n "${SNAPSHOT}" ]; then
# FIXME: What's the minimal libtool version supporting arbitrary versioning?
	DEPEND="${DEPEND}
		>=sys-devel/autoconf-2.57
		>=sys-devel/automake-1.7
		>=sys-devel/libtool-1.5
		>=sys-devel/m4-1.4"
fi

# If we're a font package, but not the font.alias one
if [[ "${PN/#font}" != "${PN}" ]] && [[ "${PN}" != "font-alias" ]]; then
	RDEPEND="${RDEPEND}
		media-fonts/encodings"
	PDEPEND="${PDEPEND}
		media-fonts/font-alias"
fi

DEPEND="${DEPEND}
	dev-util/pkgconfig
	x11-misc/util-macros"

RDEPEND="${RDEPEND}"
# Shouldn't be necessary once we're in a standard location
#	x11-base/x11-env"
# FIXME: Uncomment once it's in portage
#	!x11-base/xorg-x11"

x-modular_unpack_source() {
	unpack ${A}
	cd ${S}
}

x-modular_patch_source() {
	# Use standardized names and locations with bulk patching
	# Patch directory is ${WORKDIR}/patch
	# See epatch() in eutils.eclass for more documentation
	if [ -z "${EPATCH_SUFFIX}" ] ; then
		EPATCH_SUFFIX="patch"
	fi

	# For specific list of patches
	if [ -n "${PATCHES}" ] ; then
		for PATCH in ${PATCHES}
		do
			epatch ${PATCH}
		done
	# For non-default directory bulk patching
	elif [ -n "${PATCH_LOC}" ] ; then
		epatch ${PATCH_LOC}
	# For standard bulk patching
	elif [ -d "${EPATCH_SOURCE}" ] ; then
		epatch
	fi
}

x-modular_reconf_source() {
	# Run autoreconf for CVS snapshots only
	if [ "${SNAPSHOT}" = "yes" ]
	then
		# If possible, generate configure if it doesn't exist
		if [ -f "${S}/configure.ac" ]
		then
			einfo "Running autoreconf..."
			autoreconf -v --install
		fi
	fi

}

x-modular_src_unpack() {
	x-modular_unpack_source
	x-modular_patch_source
	x-modular_reconf_source
}

x-modular_src_compile() {
	# If prefix isn't set here, .pc files cause problems
	if [ -x ./configure ]; then
		econf --prefix=${XDIR} \
			--datadir=${XDIR}/share \
			${CONFIGURE_OPTIONS}
	fi
	emake || die "emake failed"
}

x-modular_src_install() {
	# Install everything to ${XDIR}
	make \
		DESTDIR="${D}" \
		install
# Shouldn't be necessary in XDIR=/usr
# einstall forces datadir, so we need to re-force it
#		datadir=${XDIR}/share \
#		mandir=${XDIR}/share/man \
}

x-modular_pkg_postinst() {
	if [[ -n "${FONT}" ]]; then
		setup_fonts
	fi
}

setup_fonts() {
	if [[ ! -n "${FONT_DIRS}" ]]; then
		msg="FONT_DIRS empty. Set it to at least one subdir of /usr/share/fonts."
		eerror ${msg}
		die ${msg}
	fi

	create_fonts_scale
	create_fonts_dir
	fix_font_permissions
	create_font_cache
}

create_fonts_scale() {
	ebegin "Creating fonts.scale files"
		local x
		for FONT_DIR in ${FONT_DIRS}; do
			x=${ROOT}/usr/share/fonts/${FONT_DIR}
			[ -z "$(ls ${x}/)" ] && continue
			[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

			# Only generate .scale files if truetype, opentype or type1
			# fonts are present ...

			# First truetype (ttf,ttc)
			# NOTE: ttmkfdir does NOT work on type1 fonts (#53753)
			# Also, there is no way to regenerate Speedo/CID fonts.scale
			# <spyderous@gentoo.org> 2 August 2004
			if [ "${x/encodings}" = "${x}" -a \
				-n "$(find ${x} -iname '*.tt[cf]' -print)" ]; then
				if [ -x ${ROOT}/usr/bin/ttmkfdir ]; then
					LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
					${ROOT}/usr/bin/ttmkfdir -x 2 \
						-e ${ROOT}/usr/share/fonts/encodings/encodings.dir \
						-o ${x}/fonts.scale -d ${x}
					# ttmkfdir fails on some stuff, so try mkfontscale if it does
					local ttmkfdir_return=$?
				else
					# We didn't use ttmkfdir at all
					local ttmkfdir_return=2
				fi
				if [ ${ttmkfdir_return} -ne 0 ]; then
					LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
					${ROOT}/usr/bin/mkfontscale \
						-a /usr/share/fonts/encodings/encodings.dir \
						-- ${x}
				fi
			# Next type1 and opentype (pfa,pfb,otf,otc)
			elif [ "${x/encodings}" = "${x}" -a \
				-n "$(find ${x} -iname '*.[po][ft][abcf]' -print)" ]; then
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
				${ROOT}/usr/bin/mkfontscale \
					-a ${ROOT}/usr/share/fonts/encodings/encodings.dir \
					-- ${x}
			fi
		done
	eend 0
}

create_fonts_dir() {
	ebegin "Generating fonts.dir files"
		for FONT_DIR in ${FONT_DIRS}; do
			x=${ROOT}/usr/share/fonts/${FONT_DIR}
			[ -z "$(ls ${x}/)" ] && continue
			[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

			if [ "${x/encodings}" = "${x}" ]; then
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
				${ROOT}/usr/bin/mkfontdir \
					-e ${ROOT}/usr/share/fonts/encodings \
					-e ${ROOT}/usr/share/fonts/encodings/large \
					-- ${x}
			fi
		done
	eend 0
}

fix_font_permissions() {
	ebegin "Fixing permissions"
		for FONT_DIR in ${FONT_DIRS}; do
			find ${ROOT}/usr/share/fonts/${FONT_DIR} -type f -name 'font.*' \
				-exec chmod 0644 {} \;
		done
	eend 0
}

create_font_cache() {
	# danarmak found out that fc-cache should be run AFTER all the above
	# stuff, as otherwise the cache is invalid, and has to be run again
	# as root anyway
	if [ -x ${ROOT}/usr/bin/fc-cache ]; then
		ebegin "Creating FC font cache"
			HOME="/root" ${ROOT}/usr/bin/fc-cache
		eend 0
	fi
}
