# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/joe/joe-3.0-r1.ebuild,v 1.12 2004/07/16 02:52:25 tgall Exp $

inherit flag-o-matic gnuconfig

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

	use ppc64 && gnuconfig_update

	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ChangeLog HINTS INFO LIST NEWS README README.cvs TODO
}

pkg_postinst() {
	echo
	einfo "Global configuration has been moved from /etc to /etc/joe."
	einfo "You should move or remove your old configuration files."
	echo
}
