# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/aterm/aterm-0.4.2-r8.ebuild,v 1.11 2004/08/03 14:38:46 spock Exp $

inherit eutils

IUSE="cjk"
DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatibility"
SRC_URI="mirror://sourceforge/aterm/${P}.tar.bz2
	cjk? (http://dev.gentoo.org/~spock/portage/distfiles/aterm-0.4.2-ja.patch)"
HOMEPAGE="http://aterm.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha amd64"

DEPEND="media-libs/jpeg
	media-libs/libpng
	virtual/x11"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}/src
	cp feature.h feature.h.orig
	sed "s:\(#define LINUX_KEYS\):/\*\1\*/:" \
		feature.h.orig > feature.h

	cd ${S}
	epatch ${FILESDIR}/aterm-0.4.2-borderless.patch
	epatch ${FILESDIR}/aterm-0.4.2-paste.patch
	epatch ${FILESDIR}/aterm-0.4.2-paste_mouse_outside.patch

	if use cjk ; then
		epatch ${DISTDIR}/aterm-0.4.2-ja.patch
	else
		epatch ${FILESDIR}/aterm-0.4.2-copynpaste-r2.patch
	fi

	epatch ${FILESDIR}/aterm-0.4.2-patch-pack000.patch
}

src_compile() {
	local myconf

	# You can't --enable-big5 with aterm-0.4.2-ja.patch
	# I think it's very bad thing but as nobody complains it
	# and we don't have per-language flag atm, I stick to
	# use --enable-kanji/--enable-thai (and leave --enable-big5)
	use cjk && myconf="$myconf
		--enable-kanji
		--enable-thai
		--enable-xim
		--enable-linespace"

	econf \
		--enable-transparency \
		--enable-fading \
		--enable-background-image \
		--enable-menubar \
		--enable-graphics \
		--enable-utmp \
		--with-x \
		${myconf} || die

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
	einfo
	einfo "Hint: you can copy text from aterm to the clipboard by holding the ALT key"
	einfo "while highlighting the text."
	einfo
}
