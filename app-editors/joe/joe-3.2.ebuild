# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/joe/joe-3.2.ebuild,v 1.11 2006/04/06 13:02:40 vapier Exp $

inherit flag-o-matic

DESCRIPTION="A free ASCII-Text Screen Editor for UNIX"
HOMEPAGE="http://sourceforge.net/projects/joe-editor/"
SRC_URI="mirror://sourceforge/joe-editor/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="alpha amd64 arm mips ppc ~ppc-macos ppc64 sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2-r2"
PROVIDE="virtual/editor"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fix bug #50271 (joe 3.0 documentation doesn't reflect new config file location)
	sed -e 's:${prefix}/etc/joerc:@sysconfdir@/joe/joerc:' -i joerc.in
	for i in jmacsrc.in jpicorc.in jstarrc.in rjoerc.in joe.1.in
	do
		sed -e 's:@sysconfdir@/:@sysconfdir@/joe/:' -i ${i}
	done
}

src_compile() {
	# Bug 34609 (joe 2.9.8 editor seg-faults on 'find and replace' when compiled with -Os)
	replace-flags "-Os" "-O2"

	econf || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc ChangeLog HINTS INFO LIST NEWS README TODO
}

pkg_postinst() {
	echo
	einfo "Global configuration has been moved from /etc to /etc/joe."
	einfo "You should move or remove your old configuration files."
	echo
}
