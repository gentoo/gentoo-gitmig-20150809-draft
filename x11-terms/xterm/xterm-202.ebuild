# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xterm/xterm-202.ebuild,v 1.1 2005/05/10 11:58:08 seemant Exp $

inherit eutils flag-o-matic

DESCRIPTION="Terminal Emulator for X Windows"
HOMEPAGE="http://dickey.his.com/xterm/"
SRC_URI="ftp://invisible-island.net/${PN}/${P}.tgz"

LICENSE="X11"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="truetype Xaw3d unicode"

DEPEND="virtual/x11
	sys-apps/utempter
	Xaw3d? ( x11-libs/Xaw3d )"

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${PN}-no-toolbar-by-default.patch
}

src_compile() {

	filter-flags "-fstack-protector"

	econf \
		--libdir=/etc \
		--with-x \
		--with-utempter \
		--disable-setuid \
		--disable-full-tgetent \
		--disable-imake \
		--enable-ansi-color \
		--enable-88-color \
		--enable-256-color \
		--enable-broken-osc \
		--enable-broken-st \
		--enable-load-vt-fonts \
		--enable-i18n \
		--enable-wide-chars \
		--enable-doublechars \
		--enable-warnings \
		--enable-tcap-query \
		--enable-logging \
		--enable-dabbrev \
		--enable-toolbar \
		`use_enable truetype freetype` \
		`use_enable unicode luit` `use_enable unicode mini-luit` \
		`use_with Xaw3d` \
		|| die

	emake || die
}

src_install() {
	make DESTDIR=${D} install    || die
	dodoc README* INSTALL*

	# Fix permissions -- it grabs them from live system, and they can
	# be suid or sgid like they were in pre-unix98 pty or pre-utempter days,
	# respectively (#69510).
	# (info from Thomas Dickey) - Donnie Berkholz <spyderous@gentoo.org>
	fperms 0755 /usr/bin/xterm

	# restore the navy blue
	sed -i "s:blue2$:blue:" ${D}/etc/X11/app-defaults/XTerm-color
}

pkg_preinst() {
	# Prevent the terminfo files from being removed.  These collide with ncurses
	# provided terminfo files.  So, now no more package collisions, yay!
	touch ${ROOT}/usr/share/terminfo/v/vs100
	touch ${ROOT}/usr/share/terminfo/x/x*
}


pkg_postinst() {
	echo
	einfo "Xterm is now built with toolbar support enabled.  The 'toolbar'"
	einfo "USE flag is gone away from this release onwards.  In order to run"
	einfo "xterm with the toolbar, please see the manpage or the ChangeLog"
	einfo "in /usr/share/doc/${PF}"
	echo
	epause
	ebeep
}
