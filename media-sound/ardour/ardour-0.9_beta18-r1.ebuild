# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour/ardour-0.9_beta18-r1.ebuild,v 1.1 2004/07/24 13:48:02 tigger Exp $

inherit eutils

MY_P="${P}.3"
MY_PV="${PV}.3"

DESCRIPTION="multi-track hard disk recording software"
HOMEPAGE="http://ardour.org/"
SRC_URI="http://ardour.org/releases/${MY_P/_/}.tar.bz2"

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
	=media-libs/libart_lgpl-2.3*"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P/_/}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ardour-gcc34.patch
	epatch ${FILESDIR}/ardour.aclocal.patch
}

src_compile() {
	autoconf
	local myconf="--disable-dependency-tracking --enable-optimize --disable-ksi"

	use nls || myconf="${myconf} --disable-nls"
	econf ${myconf} || die "configure failed"

	emake || die "parallel make failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc DOCUMENTATION/*
}
