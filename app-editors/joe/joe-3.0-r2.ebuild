# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/joe/joe-3.0-r2.ebuild,v 1.4 2007/01/05 07:16:56 flameeyes Exp $

inherit flag-o-matic eutils

DESCRIPTION="A free ASCII-Text Screen Editor for UNIX"
HOMEPAGE="http://sourceforge.net/projects/joe-editor/"
SRC_URI="mirror://sourceforge/joe-editor/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips amd64 ppc64"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2-r2"
PROVIDE="virtual/editor"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix for non-critical buffer overflow, bug #71129
	epatch ${FILESDIR}/${P}-overflow.patch || die "epatch failed"
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
	make install DESTDIR=${D} || die "make install failed"
	dodoc ChangeLog HINTS INFO LIST NEWS README README.cvs TODO
}

pkg_postinst() {
	echo
	einfo "Global configuration has been moved from /etc to /etc/joe."
	einfo "You should move or remove your old configuration files."
	echo
}
