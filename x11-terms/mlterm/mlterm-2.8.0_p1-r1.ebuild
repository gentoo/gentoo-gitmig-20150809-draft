# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.8.0_p1-r1.ebuild,v 1.10 2004/07/30 03:11:15 tgall Exp $

inherit eutils

IUSE="truetype gtk gtk2 imlib bidi nls"

MY_P="${P/_p?/}"
PATCH_P="${P/_p/pl}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${MY_P}.tar.gz
	mirror://sourceforge/mlterm/${PATCH_P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc hppa ppc64"
LICENSE="BSD"

# mlterm itself could use either gdk-pixbuf2, gdk-pixbuf1 or imlib but
# mlconfig requires gtk+-1.2. Hence, I leave gtk+-1.2 inside gtk? clause
# even though you have gtk2 USE flag. (If you build mlterm with
# gdk-pixbuf2 mlterm won't depend on gtk+-1.2 but mlconfig does)
# See also bug 34573
DEPEND="gtk? ( gtk2? ( >=x11-libs/gtk+-2 )
		!gtk2? ( media-libs/gdk-pixbuf )
		=x11-libs/gtk+-1.2* )
	!gtk? ( imlib? ( >=media-libs/imlib-1.9.14 ) )
	truetype? ( =media-libs/freetype-2* )
	bidi? ( >=dev-libs/fribidi-0.10.4 )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PATCH_P}/${PATCH_P}.patch
}

src_compile() {
	local myconf imagelib

	if use gtk && use gtk2; then
		imagelib="gdk-pixbuf2"
	elif use gtk ; then
		imagelib="gdk-pixbuf1"
	elif use imlib ; then
		imagelib="imlib"
	fi

	use gtk || myconf="${myconf} --with-tools=mlclient,mlcc"

	econf --enable-utmp \
		`use_enable truetype anti-alias` \
		`use_enable bidi fribidi` \
		`use_enable nls` \
		--with-imagelib=${imagelib} \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall || die

	dodoc ChangeLog LICENCE README

	docinto ja
	dodoc doc/ja/*
	docinto en
	dodoc doc/en/*
}
