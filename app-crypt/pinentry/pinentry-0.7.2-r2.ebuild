# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pinentry/pinentry-0.7.2-r2.ebuild,v 1.8 2006/01/03 17:12:13 plasmaroo Exp $

inherit flag-o-matic qt3

DESCRIPTION="Collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="http://www.gnupg.org/aegypten/"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
IUSE="gtk ncurses qt"

DEPEND="gtk? ( =x11-libs/gtk+-2* )
	ncurses? ( sys-libs/ncurses )
	qt? ( $(qt_min_version 3.3) )
	!gtk? ( !qt? ( !ncurses? ( sys-libs/ncurses ) ) )"

src_compile() {
	local myconf=""

	if ! ( use qt || use gtk || use ncurses )
	then
		myconf="--enable-pinentry-curses --enable-fallback-curses"
	fi

	append-ldflags $(bindnow-flags)

	econf \
		--disable-dependency-tracking \
		--enable-maintainer-mode \
		--disable-pinentry-gtk \
		$(use_enable gtk pinentry-gtk2) \
		$(use_enable qt pinentry-qt) \
		$(use_enable ncurses pinentry-curses) \
		$(use_enable ncurses fallback-curses) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO || die "dodoc failed"

	# gtk versions of pinentry refuse to start when suid root
	for x in curses qt
	do
		[ -f "${D}"/usr/bin/pinentry-${x} ] && fperms u+s /usr/bin/pinentry-${x}
	done
}

pkg_postinst() {
	einfo "pinentry-curses and pinentry-qt are installed SUID root to make use of"
	einfo "protected memory space. This is needed in order to have a secure place"
	einfo "to store your passphrases, etc. at runtime but may make some sysadmins"
	einfo "nervous."
}
