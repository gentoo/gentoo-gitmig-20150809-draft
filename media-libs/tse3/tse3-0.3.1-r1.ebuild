# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tse3/tse3-0.3.1-r1.ebuild,v 1.6 2008/06/09 11:42:33 flameeyes Exp $

inherit eutils flag-o-matic libtool autotools

DESCRIPTION="TSE3 Sequencer library"
HOMEPAGE="http://TSE3.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="alsa oss arts"

RDEPEND="alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Try to support OSS, awe_voice.h has been removed from
	# linux-headers. Using a modified copy from 2.6.17.
	# Bug 188163.
	if use oss; then
		cp "${FILESDIR}"/awe_voice.h src/
		append-flags -DHAVE_AWE_VOICE_H
	fi

	# support 64bit machines properly
	epatch "${FILESDIR}"/${PN}-0.2.7-size_t-64bit.patch
	# gcc-4 patch (bug #100708)
	epatch "${FILESDIR}"/${PN}-0.2.7-gcc4.patch

	epatch "${FILESDIR}/${P}-parallelmake.patch"

	epatch "${FILESDIR}"/${P}+gcc-4.3.patch

	eautoreconf
	elibtoolize
}

src_compile() {
	local myconf="--without-doc-install"

	use arts || myconf="${myconf} --without-arts"
	use alsa || myconf="${myconf} --without-alsa"
	use oss || myconf="${myconf} --without-oss"

	econf ${myconf} || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README THANKS TODO doc/History
	dohtml doc/*.{html,gif,png}
}
