# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gtalk/gtalk-0.99.10.ebuild,v 1.1 2004/01/04 11:55:30 aliz Exp $

inherit elisp

DESCRIPTION="GNU Replacement for talk/ntalk programs"
HOMEPAGE="http://gnutalk.sourceforge.net/"
SRC_URI="http://gnutalk.sourceforge.net/files/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	ncurses? ( >=sys-libs/ncurses-5.2 )
	gtk? ( =x11-libs/gtk+-1* )
	X? ( virtual/x11 )"

IUSE="X gtk ncurses"

src_compile() {
	local myconf=""

	if use X; then
		myconf="$myconf --with-x"
		if use gtk; then
			myconf="$myconf --with-x-toolkit=gtk"
		else
			myconf="$myconf --with-x-toolkit=athena"
		fi
	else
		myconf="myconf --without-x"
	fi

	if use ncurses; then
		myconf="$myconf --with-curses=ncurses"
	else
		myconf="$myconf --with-curses=no"
	fi

	econf ${myconf}             || die
	emake lispdir="${SITELISP}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" lispdir="${SITELISP}" install || \
		die "make install failed"
	dodoc AUTHORS BUGS ChangeLog EMBEDDED.TXT NEWS README TODO || \
		die "dodoc failed"

	insinto /usr/lib/X11/app-defaults
	doins Gtalk || die "doins failed"

	#insinto /etc/xinetd.d
	#insopts -m 0644 -o root -g root
	#doins "${FILESDIR}/xinetd.d-${PV}/*" || die "doins failed"
}

