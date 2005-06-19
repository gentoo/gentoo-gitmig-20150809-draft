# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/seyon/seyon-2.20c.ebuild,v 1.5 2005/06/19 23:47:17 smithj Exp $

inherit eutils

DESCRIPTION="telecommunications package for X"
HOMEPAGE="http://freshmeat.net/projects/seyon/"
SRC_URI="mirror://debian/pool/main/s/seyon/seyon_2.20c.orig.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
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
