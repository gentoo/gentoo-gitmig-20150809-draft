# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour/ardour-0.9_beta29.ebuild,v 1.2 2005/04/24 09:16:02 jnc Exp $

inherit eutils

DESCRIPTION="multi-track hard disk recording software"
HOMEPAGE="http://ardour.org/"
SRC_URI="http://ardour.org/releases/${P/_/}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="nls debug"

RDEPEND="dev-util/pkgconfig
	>=media-libs/liblrdf-0.3.6
	>=media-libs/raptor-1.2.0
	>=media-sound/jack-audio-connection-kit-0.98.1
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=media-libs/libsndfile-1.0.4
	sys-libs/gdbm
	>=media-libs/ladspa-sdk-1.12
	>=media-libs/libsamplerate-0.0.14
	>=dev-libs/libxml2-2.5.7
	>=media-libs/libart_lgpl-2.3.16
	>=dev-util/scons-0.96.1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${P/_/}"

src_compile() {
	# Required for scons to "see" intermediate install location
	mkdir -p ${D}
	DBUG=no ; if useq debug ; then DBUG=yes ; fi
	scons DEBUG=${DBUG} DESTDIR=${D} PREFIX=/usr KSI=0 -j2
}

src_install() {
	scons install || die "make install failed"

	# Workaround for xorg bug concerning lucida fonts. bug 73056. (2004 Dec 3 eldad)
	# This workaround is no longer required as of ardour-0.9_beta29
	# as it is already implemented in ardour_ui.rc
	#sed -e 's/lucida[^-]*-/helvetica-/' -i ${D}/etc/ardour/ardour_ui.rc

	dodoc DOCUMENTATION/*
}
