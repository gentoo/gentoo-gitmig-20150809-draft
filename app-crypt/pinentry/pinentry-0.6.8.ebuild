# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pinentry/pinentry-0.6.8.ebuild,v 1.3 2003/07/31 23:04:39 vapier Exp $

DESCRIPTION="collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="http://www.gnupg.org/aegypten/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE="qt gtk ncurses"

DEPEND="gtk? ( x11-libs/gtk+ )
	ncurses? ( sys-libs/ncurses )
	qt? ( x11-libs/qt )"

pkg_setup() {
	use qt || use gtk || use ncurses || die "You must have at least one of 'qt', 'gtk', or 'ncurses' in your USE"
}

src_compile() {
	econf	$(use_enable qt pinentry-qt) \
			$(use_enable gtk pinentry-gtk) \
			$(use_enable ncurses pinentry-curses) \
			$(use_enable ncurses fallback-curses) \
			--disable-dependency-tracking
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO

	# The other two pinentries don't spit out an insecure memory warning when
	# not suid root, and gtk refuses to start if pinentry-gtk is suid root.
	chmod +s "${D}"/usr/bin/pinentry-qt
}

pkg_postinst() {
	einfo "pinentry-qt is installed SUID root to make use of protected memory space"
	einfo "This is needed in order to have a secure place to store your passphrases,"
	einfo "etc. at runtime but may make some sysadmins nervous"
}
