# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour/ardour-0.9_beta11-r1.ebuild,v 1.2 2004/04/06 03:06:34 vapier Exp $

inherit flag-o-matic

MY_P="${P}.2"
MY_PV="${PV}.2"

DESCRIPTION="multi-track hard disk recording software"
HOMEPAGE="http://ardour.org/"
SRC_URI="http://ardour.org/releases/${MY_P/_/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls ardour-ksi"

DEPEND="dev-util/pkgconfig
	>=media-libs/liblrdf-0.3.1
	virtual/jack
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=media-libs/libsndfile-1.0.4
	sys-libs/gdbm
	>=media-libs/ladspa-sdk-1.12
	>=media-libs/libsamplerate-0.0.14
	>=media-libs/liblrdf-0.3.1
	>=dev-libs/libxml2-2.5.7
	=media-libs/libart_lgpl-2.3*"
RDEPEND="nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P/_/}"

src_compile() {
	local myconf="--disable-dependency-tracking --enable-optimize"
	local myarch

	use nls || myconf="${myconf} --disable-nls"
	use ardour-ksi || myconf="${myconf} --disable-ksi"
	econf ${myconf} || die "configure failed"

	emake || die "parallel make failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc DOCUMENTATION/*
}
