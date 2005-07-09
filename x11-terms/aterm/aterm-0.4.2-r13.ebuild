# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/aterm/aterm-0.4.2-r13.ebuild,v 1.2 2005/07/09 19:27:37 swegener Exp $

inherit eutils flag-o-matic

DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatibility"
HOMEPAGE="http://aterm.sourceforge.net"
SRC_URI="mirror://sourceforge/aterm/${P}.tar.bz2
	linguas_ja? ( http://dev.gentoo.org/~spock/portage/distfiles/aterm-0.4.2-ja.patch )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="xgetdefault"

DEPEND="media-libs/jpeg
	media-libs/libpng
	virtual/x11"

pkg_setup() {
	if use linguas_ja && use linguas_zh_TW ; then
		eerror
		eerror "You cannot have both ja and zh_TW enabled."
		eerror
		die "Please remove either ja or zh_TW from your LINGUAS."
	fi
}

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}/src
	cp feature.h feature.h.orig
	sed "s:\(#define LINUX_KEYS\):/\*\1\*/:" \
		feature.h.orig > feature.h

	sed -i "s:    KeySym          keysym;:    KeySym          keysym = 0;:" command.c

	cd ${S}
	epatch ${FILESDIR}/aterm-0.4.2-borderless.patch
	epatch ${FILESDIR}/aterm-0.4.2-paste.patch
	epatch ${FILESDIR}/aterm-0.4.2-paste_mouse_outside.patch

	if use linguas_ja ; then
		epatch ${DISTDIR}/aterm-0.4.2-ja.patch
	else
		epatch ${FILESDIR}/aterm-0.4.2-copynpaste-r3.patch
	fi

	epatch ${FILESDIR}/aterm-0.4.2-patch-pack000.patch

	if use linguas_ja ; then
		epatch ${FILESDIR}/aterm-0.4.2-ja-savelines.patch
	else
		epatch ${FILESDIR}/aterm-0.4.2-savelines.patch
	fi

	epatch ${FILESDIR}/aterm-0.4.2-internal-border.patch
	epatch ${FILESDIR}/aterm-0.4.2-scroll-double-free.patch
}

src_compile() {
	local myconf

	# macos doesn't support -z flag
	if ! use ppc-macos ; then
		append-ldflags -Wl,-z,now
	fi

	econf \
		$(use_enable xgetdefault) \
		$(use_enable linguas_ja kanji) \
		$(use_enable linguas_zh_TW big5) \
		$(use_enable linguas_th thai) \
		--with-terminfo=/usr/share/terminfo \
		--enable-transparency \
		--enable-fading \
		--enable-background-image \
		--enable-menubar \
		--enable-graphics \
		--enable-utmp \
		--enable-linespace \
		--enable-xim \
		--with-x \
		${myconf} || die

	sed -i -re 's#^XLIB = (.*)#XLIB = \1 -lXmu#' src/Makefile
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	fowners root:utmp /usr/bin/aterm
	fperms g+s /usr/bin/aterm

	doman doc/aterm.1
	dodoc ChangeLog INSTALL doc/BUGS doc/FAQ doc/README.*
	docinto menu
	dodoc doc/menu/*
	dohtml -r .
}

pkg_postinst () {
	echo
	einfo "Hint: you can copy text from aterm to the clipboard by holding the ALT key"
	einfo "while highlighting the text."
	echo
	ewarn "The transparent background will only work if you have the 'real' root wallpaper"
	ewarn "set. Use Esetroot (x11-terms/eterm) or fbsetbg (x11-wm/fluxbox) if you are"
	ewarn "experiencing problems with transparency in aterm."
	echo
}
