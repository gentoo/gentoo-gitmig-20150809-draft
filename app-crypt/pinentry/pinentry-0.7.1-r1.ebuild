# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pinentry/pinentry-0.7.1-r1.ebuild,v 1.6 2004/12/07 22:44:09 swegener Exp $

inherit eutils

DESCRIPTION="collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="http://www.gnupg.org/aegypten/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/pinentry/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="qt gtk ncurses"

DEPEND="gtk? ( =x11-libs/gtk+-1* )
	ncurses? ( sys-libs/ncurses )
	qt? ( x11-libs/qt )
	!gtk? ( !qt? ( !ncurses? ( sys-libs/ncurses ) ) )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/qt-compile-fix.diff
}

src_compile() {
	local myconf=""
	if ! use qt && ! use gtk && ! use ncurses ; then
		myconf="--enable-pinentry-curses --enable-fallback-curses"
	fi
	econf \
		`use_enable qt pinentry-qt` \
		`use_enable gtk pinentry-gtk` \
		`use_enable ncurses pinentry-curses` \
		`use_enable ncurses fallback-curses` \
		--disable-dependency-tracking \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO

	# The other two pinentries don't spit out an insecure memory warning when
	# not suid root, and gtk refuses to start if pinentry-gtk is suid root.
	fperms +s /usr/bin/pinentry-qt
}

pkg_postinst() {
	einfo "pinentry-qt is installed SUID root to make use of protected memory space"
	einfo "This is needed in order to have a secure place to store your passphrases,"
	einfo "etc. at runtime but may make some sysadmins nervous"
}
