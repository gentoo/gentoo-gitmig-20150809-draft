# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/seyon/seyon-2.20c.ebuild,v 1.1 2004/03/01 09:28:33 cyfred Exp $

DESCRIPTION="Seyon is a complete full-featured telecommunications package for the X Window System. Some of its features are: dialing directory, scripting language, external file transfer protocol support, zmodem auto-download and configurable keyboard translation modes."
HOMEPAGE="http://www.debian.org/"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/s/seyon/seyon_2.20c.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	epatch ${FILESDIR}/${P}-compile-fix.patch

	#fixes pronlem with lockfiles #38264
	epatch ${FILESDIR}/${P}-lock-file-fix.patch

	export PATH="/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin/"
	xmkmf || die "xmkmf failed"

	chmod 0750 makever.sh || die "could not set executable permissions to makever.sh"

	epatch ${FILESDIR}/${P}-makefile-patch.patch

	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man
}

pkg_postinst() {
	mkdir /var/lock/uucp
	touch /var/lock/seyon_locks
}

DOCS="1-BUGREPORT 1-CHANGES 1-COPYING 1-FAQ 1-HISTORY 1-INSTALL 1-PORTING 1-README 1-SURVEY 1-TODO COPYING"
