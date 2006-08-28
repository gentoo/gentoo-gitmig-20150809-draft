# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/flac/flac-1.1.2-r3.ebuild,v 1.11 2006/08/28 02:04:35 kumba Exp $

inherit libtool eutils flag-o-matic

PATCHLEVEL="1"
DESCRIPTION="free lossless audio encoder which includes an XMMS plugin"
HOMEPAGE="http://flac.sourceforge.net/"
SRC_URI="mirror://sourceforge/flac/${P}.tar.gz
	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 sh sparc x86"
IUSE="3dnow debug doc ogg sse xmms"

RDEPEND="ogg? ( >=media-libs/libogg-1.0_rc2 )
	xmms? ( media-sound/xmms )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	sys-apps/gawk
	doc? ( app-doc/doxygen )
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/patches

	# it needs XMMS m4 file
	cp -R ${WORKDIR}/m4 ${S}

	./autogen.sh || die "autogen failed"
	libtoolize --copy --force
	elibtoolize --reverse-deps
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

	# parallel make seems to mess up the building of the xmms input plugin
	emake -j1 || die "make failed"
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
