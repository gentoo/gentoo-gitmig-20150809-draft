# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pinentry/pinentry-0.7.2.ebuild,v 1.5 2005/04/01 20:07:45 hansmi Exp $

inherit flag-o-matic

DESCRIPTION="collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="http://www.gnupg.org/aegypten/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64 alpha ia64 ~sparc"
IUSE="gtk gtk2 ncurses qt"

DEPEND="gtk? (
		!gtk2? ( =x11-libs/gtk+-1* )
		gtk2? ( =x11-libs/gtk+-2* )
	)
	ncurses? ( sys-libs/ncurses )
	qt? ( x11-libs/qt )
	!gtk? ( !qt? ( !ncurses? ( sys-libs/ncurses ) ) )"

src_compile() {
	local myconf=""

	if ! ( use qt || use gtk || use ncurses )
	then
		myconf="--enable-pinentry-curses --enable-fallback-curses --disable-pinentry-gtk --disable-pinentry-gtk2"
	elif use gtk && use gtk2
	then
		myconf="--enable-pinentry-gtk2 --disable-pinentry-gtk"
	elif use gtk
	then
		myconf="--enable-pinentry-gtk --disable-pinentry-gtk2"
	else
		myconf="--disable-pinentry-gtk --disable-pinentry-gtk2"
	fi

	append-ldflags -Wl,-z,now

	econf \
		--disable-dependency-tracking \
		--enable-maintainer-mode \
		$(use_enable qt pinentry-qt) \
		$(use_enable ncurses pinentry-curses) \
		$(use_enable ncurses fallback-curses) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die "dodoc failed"

	# gtk versions of pinentry refuse to start when suid root
	for x in curses qt
	do
		[ -f ${D}/usr/bin/pinentry-${x} ] && fperms +s /usr/bin/pinentry-${x}
	done
}

pkg_postinst() {
	einfo "pinentry-curses and pinentry-qt are installed SUID root to make use of"
	einfo "protected memory space. This is needed in order to have a secure place"
	einfo "to store your passphrases, etc. at runtime but may make some sysadmins"
	einfo "nervous."
}
