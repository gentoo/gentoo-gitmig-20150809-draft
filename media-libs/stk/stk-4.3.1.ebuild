# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/stk/stk-4.3.1.ebuild,v 1.2 2009/01/13 07:45:33 aballier Exp $

inherit eutils autotools

DESCRIPTION="Synthesis ToolKit in C++"
HOMEPAGE="http://ccrma.stanford.edu/software/stk/"
SRC_URI="http://ccrma.stanford.edu/software/stk/release/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa debug doc jack oss"

RDEPEND="alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-cflags-lib.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${P}-fpic.patch"
	epatch "${FILESDIR}/${P}-missing.patch"
	epatch "${FILESDIR}/${P}-ldflags.patch"
	eautoreconf
}

src_compile() {
	local myconf
	# --without-jack is broken in autofoo, see #232302
	use jack && myconf="--with-jack"

	econf \
		`use_with alsa` \
		`use_with oss` \
		`use_enable debug` \
		RAWWAVE_PATH=/usr/share/stk/rawwaves/ \
		${myconf} \
		|| die "configure failed!"

	# compile libstk
	cd src
	emake || die "make in src failed!"
}

src_install() {
	dodoc README
	# install the lib
	dolib src/libstk.*
	# install headers
	insinto /usr/include/stk
	doins include/*.h include/*.msg include/*.tbl
	# install rawwaves
	insinto /usr/share/stk/rawwaves
	doins rawwaves/*.raw
	# install docs
	if use doc; then
		dohtml -r doc/html/*
	fi
}
