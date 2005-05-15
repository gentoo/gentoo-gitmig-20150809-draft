# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/flac/flac-1.1.2-r1.ebuild,v 1.4 2005/05/15 02:22:05 flameeyes Exp $

inherit libtool eutils flag-o-matic

DESCRIPTION="free lossless audio encoder which includes an XMMS plugin"
HOMEPAGE="http://flac.sourceforge.net/"
SRC_URI="mirror://sourceforge/flac/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="3dnow debug doc ogg sse xmms"

RDEPEND="ogg? ( >=media-libs/libogg-1.0_rc2 )
	xmms? ( media-sound/xmms )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	sys-apps/gawk
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use xmms ; then
		epatch "${FILESDIR}"/${P}-xmms-config.patch
	else
		sed -i -e '/^@FLaC__HAS_XMMS_TRUE/d' src/Makefile.in || die
		sed -i -e '/AM_PATH_XMMS/d' configure.in || die
	fi

	epatch "${FILESDIR}/${P}-m4.patch"
	epatch "${FILESDIR}/${P}-libtool.patch"
	epatch "${FILESDIR}/${P}-gas.patch"
	epatch "${FILESDIR}/${P}-makefile.patch"
	epatch "${FILESDIR}/${P}-noogg.patch"
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

	# emake seems to mess up the building of the xmms input plugin
	make || die "make failed"
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
