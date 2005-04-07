# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/aterm/aterm-1.00_beta2.ebuild,v 1.3 2005/04/07 13:26:27 spock Exp $

inherit eutils flag-o-matic

MY_P="${P/_/.}"

DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatibility"
HOMEPAGE="http://aterm.sourceforge.net"
SRC_URI="ftp://ftp.afterstep.org/apps/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="cjk xgetdefault"

DEPEND="media-libs/jpeg
		media-libs/libpng
		>=x11-wm/afterstep-2
		virtual/x11"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/aterm-0.4.2-scroll-double-free.patch
}

src_compile() {
	local myconf

	append-ldflags -Wl,-z,now

	use cjk && myconf="$myconf
		--enable-kanji
		--enable-thai
		--enable-big5"

	econf \
		$(use_enable xgetdefault) \
		--with-terminfo=/usr/share/terminfo \
		--enable-transparency \
		--enable-fading \
		--enable-background-image \
		--enable-menubar \
		--enable-graphics \
		--enable-utmp \
		--enable-wtmp \
		--with-x \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	fowners root:utmp /usr/bin/aterm
	fperms g+s /usr/bin/aterm

	doman doc/aterm.1
	dodoc ChangeLog doc/BUGS doc/FAQ doc/README.*
	docinto menu
	dodoc doc/menu/*
	dohtml -r .
}

pkg_postinst() {
	echo ""
	ewarn "The transparent background will only work if you have the 'real' root wallpaper"
	ewarn "set. Use Esetroot (x11-terms/eterm) or fbsetbg (x11-wm/fluxbox) if you are"
	ewarn "experiencing problems with transparency in aterm."
	echo ""
}

