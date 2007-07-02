# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/vtwm/vtwm-5.4.7.ebuild,v 1.1 2007/07/02 10:54:16 coldwind Exp $

inherit eutils

DESCRIPTION="one of many TWM descendants and implements a Virtual Desktop"
HOMEPAGE="http://www.vtwm.org/"
SRC_URI="http://www.vtwm.org/downloads/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~ppc ~sparc ~x86"
IUSE="rplay"

RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXext
	x11-libs/libXpm
	rplay? ( media-sound/rplay )"
DEPEND="${RDEPEND}
	x11-misc/imake
	app-text/rman
	x11-proto/xproto
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-dont-use-local-path.patch"
	if ! use rplay ; then
		sed -e "s:^XCOMM\ \(.*NO_SOUND\):\1:" \
			-e "s:^\(SOUNDLIB.*\):XCOMM\ \1:" -i Imakefile || die "sed failed"
	fi
}

src_compile() {
	xmkmf || die "xmkmf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake BINDIR=/usr/bin \
		LIBDIR=/etc/X11 \
		MANPATH=/usr/share/man \
		DESTDIR="${D}" install || die "emake install failed"

	echo "#!/bin/sh" > vtwm
	echo "xsetroot -cursor_name left_ptr &" >> vtwm
	echo "/usr/bin/vtwm" >> vtwm
	exeinto /etc/X11/Sessions
	doexe vtwm || die
	dodoc doc/{4.7.*,CHANGELOG,BUGS,DEVELOPERS,HISTORY,SOUND,WISHLIST} || die
}
