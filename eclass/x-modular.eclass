# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/x-modular.eclass,v 1.1 2005/08/08 02:57:50 spyderous Exp $
#
# Author: Donnie Berkholz <spyderous@gentoo.org>
#
# This eclass is designed to reduce code duplication in the modularized X11
# ebuilds.

EXPORT_FUNCTIONS src_unpack src_compile src_install

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
