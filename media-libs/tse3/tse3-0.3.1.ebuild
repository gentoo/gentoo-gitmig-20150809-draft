# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tse3/tse3-0.3.1.ebuild,v 1.3 2007/04/04 13:58:25 gustavoz Exp $

inherit eutils libtool autotools

DESCRIPTION="TSE3 Sequencer library"
HOMEPAGE="http://TSE3.sourceforge.net/"
SRC_URI="mirror://sourceforge/tse3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc ~x86"
IUSE="alsa oss arts"

RDEPEND="alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )"

DEPEND="${RDEPEND}
	sys-devel/automake
	sys-devel/autoconf
	sys-devel/libtool"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# support 64bit machines properly
	epatch "${FILESDIR}"/${PN}-0.2.7-size_t-64bit.patch
	# gcc-4 patch (bug #100708)
	epatch "${FILESDIR}"/${PN}-0.2.7-gcc4.patch

	epatch "${FILESDIR}/${P}-parallelmake.patch"

	eautoreconf
	elibtoolize
}

src_compile() {
	local myconf="--without-doc-install"

	use arts || myconf="${myconf} --without-arts"
	use alsa || myconf="${myconf} --without-alsa"
	use oss || myconf="${myconf} --without-oss"

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README THANKS TODO doc/History
	dohtml doc/*.html doc/*.gif doc/*.png
}
