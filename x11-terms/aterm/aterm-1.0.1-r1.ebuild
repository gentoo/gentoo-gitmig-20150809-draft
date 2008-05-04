# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/aterm/aterm-1.0.1-r1.ebuild,v 1.6 2008/05/04 13:32:07 maekke Exp $

inherit flag-o-matic

DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatibility"
HOMEPAGE="http://aterm.sourceforge.net"
SRC_URI="ftp://ftp.afterstep.org/apps/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="background cjk xgetdefault"

RDEPEND="media-libs/jpeg
	media-libs/libpng
	background? ( x11-wm/afterstep )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libICE"

DEPEND="${RDEPEND}
	x11-libs/libXt
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Security bug #219746
	epatch "${FILESDIR}/${P}-display-security-issue.patch"
}

src_compile() {
	local myconf

	append-ldflags $(bindnow-flags)

	use cjk && myconf="$myconf
		--enable-kanji
		--enable-thai
		--enable-big5"

	econf \
		$(use_enable xgetdefault) \
		$(use_enable background background-image) \
		--with-terminfo=/usr/share/terminfo \
		--enable-transparency \
		--enable-fading \
		--enable-background-image \
		--enable-menubar \
		--enable-graphics \
		--enable-utmp \
		--enable-wtmp \
		--with-x \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	fowners root:utmp /usr/bin/aterm
	fperms g+s /usr/bin/aterm

	doman doc/aterm.1
	dodoc ChangeLog doc/FAQ doc/README.*
	docinto menu
	dodoc doc/menu/*
	dohtml -r .
}

pkg_postinst() {
	echo
	ewarn "The transparent background will only work if you have the 'real' root wallpaper"
	ewarn "set. Use Esetroot (x11-terms/eterm) or fbsetbg (x11-wm/fluxbox) if you are"
	ewarn "experiencing problems with transparency in aterm."
	echo
}
