# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sxid/sxid-4.0.4-r1.ebuild,v 1.2 2006/04/11 23:33:59 gustavoz Exp $

DESCRIPTION="suid, sgid file and directory checking"
SRC_URI="http://www.phunnypharm.org/pub/sxid/${P/-/_}.tar.gz"
HOMEPAGE="http://freshmeat.net/projects/sxid"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

RDEPEND="virtual/libc
		mail-client/mailx"
DEPEND="virtual/libc
	sys-apps/sed
	sys-devel/gcc
	sys-devel/autoconf"

src_compile() {
	# this is an admin application and really requires root to run correctly
	# we need to move the binary to the sbin directory
	cd source
	sed -i s/bindir/sbindir/g Makefile.in
	cd ..

	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README docs/sxid.conf.example docs/sxid.cron.example
}

pkg_postinst() {
	einfo "You will need to configure sxid.conf for your system using the manpage and example"
}
