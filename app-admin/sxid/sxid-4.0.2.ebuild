# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sxid/sxid-4.0.2.ebuild,v 1.5 2003/05/25 14:18:55 mholzer Exp $

DESCRIPTION="suid, sgid file and directory checking"
SRC_URI="http://www.phunnypharm.org/pub/sxid/${P/-/_}.tar.gz"
HOMEPAGE="http://freshmeat.net/projects/sxid"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc"

src_compile() {
	# this is an admin application and really requires root to run correctly
	# we need to move the binary to the sbin directory
	cd source
	sed s/bindir/sbindir/g < Makefile.in > Makefile.in.new
	mv -f Makefile.in.new Makefile.in
	cd ..

	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README docs/sxid.conf.example docs/sxid.cron.example
}

pkg_postinst() {
	einfo "You will need to configure sxid.conf for your system using the manpage and example"
}
