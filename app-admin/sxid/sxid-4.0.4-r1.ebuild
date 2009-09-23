# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sxid/sxid-4.0.4-r1.ebuild,v 1.11 2009/09/23 15:02:36 patrick Exp $

inherit toolchain-funcs

DESCRIPTION="suid, sgid file and directory checking"
SRC_URI="http://www.phunnypharm.org/pub/sxid/${P/-/_}.tar.gz"
HOMEPAGE="http://freshmeat.net/projects/sxid"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ppc sparc x86"
IUSE=""

RDEPEND="virtual/mailx"
DEPEND="sys-apps/sed
	sys-devel/gcc
	sys-devel/autoconf"

src_compile() {
	# this is an admin application and really requires root to run correctly
	# we need to move the binary to the sbin directory
	cd source
	sed -i s/bindir/sbindir/g Makefile.in
	cd ..

	tc-export CC
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README docs/sxid.conf.example docs/sxid.cron.example
}

pkg_postinst() {
	elog "You will need to configure sxid.conf for your system using the manpage and example"
}
