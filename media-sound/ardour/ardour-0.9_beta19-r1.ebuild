# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour/ardour-0.9_beta19-r1.ebuild,v 1.2 2004/12/03 01:20:52 eldad Exp $

inherit eutils

DESCRIPTION="multi-track hard disk recording software"
HOMEPAGE="http://ardour.org/"
SRC_URI="http://ardour.org/releases/${P/_/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="nls"

RDEPEND="dev-util/pkgconfig
	>=media-libs/liblrdf-0.3.6
	>=media-sound/jack-audio-connection-kit-0.98.1
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=media-libs/libsndfile-1.0.4
	sys-libs/gdbm
	>=media-libs/ladspa-sdk-1.12
	>=media-libs/libsamplerate-0.0.14
	>=media-libs/liblrdf-0.3.1
	>=dev-libs/libxml2-2.5.7
	>=media-libs/libart_lgpl-2.3.16"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${P/_/}"

src_compile() {
	sed -i 's/OPT_FLAGS=" -pipe"/OPT_FLAGS="$OPT_FLAGS -pipe"/' \
		libs/ardour/configure \
		libs/pbd/configure \
		libs/ardour/configure \
		libs/gtkmmext/configure \
		libs/midi++/configure \
		libs/soundtouch/configure \
		gtk_ardour/configure

	local myconf="--disable-dependency-tracking --enable-optimize --disable-ksi"

	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf} || die "configure failed"

	emake || die "parallel make failed"
}

src_install() {
	einstall || die "make install failed"

	# Workaround for xorg bug concerning lucida fonts. bug 73056. (2004 Dec 3 eldad)
	sed -e 's/lucida[^-]*-/helvetica-/' -i ${D}/etc/ardour/ardour_ui.rc

	dodoc DOCUMENTATION/*
}
