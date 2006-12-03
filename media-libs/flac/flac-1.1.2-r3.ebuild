# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/flac/flac-1.1.2-r3.ebuild,v 1.15 2006/12/03 15:09:50 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit libtool eutils flag-o-matic autotools

PATCHLEVEL="1"
DESCRIPTION="free lossless audio encoder and decoder"
HOMEPAGE="http://flac.sourceforge.net/"
SRC_URI="mirror://sourceforge/flac/${P}.tar.gz
	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 sh sparc x86"
IUSE="3dnow debug doc ogg sse"

RDEPEND="ogg? ( >=media-libs/libogg-1.0_rc2 )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	sys-apps/gawk
	doc? ( app-doc/doxygen )
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Hard-disable the XMMS plugin now that XMMS is removed.
	sed -i -e '/AM_PATH_XMMS/s:^.*$:true:' "${S}/configure.in"

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/patches

	AT_M4DIR="${WORKDIR}/m4" eautoreconf
}

src_compile() {
	use doc || export ac_cv_prog_DOXYGEN=''
	econf \
		$(use_enable ogg) \
		$(use_enable sse) \
		$(use_enable 3dnow) \
		$(use_enable debug) \
		--disable-dependency-tracking || die

	# the man page ebuild requires docbook2man... yick!
	sed -i -e 's:include man:include:g' Makefile

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
}

pkg_postinst() {
	ewarn "If you've upgraded from a previous version of flac, you may need to re-emerge"
	ewarn "packages that linked against flac by running:"
	ewarn "revdep-rebuild"
}

# see #59482
src_test() { :; }
