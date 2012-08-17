# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sxid/sxid-4.2.ebuild,v 1.2 2012/08/17 17:10:32 kensington Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="suid, sgid file and directory checking"
HOMEPAGE="http://freshmeat.net/projects/sxid"
SRC_URI="http://linukz.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="virtual/mailx"
DEPEND="sys-apps/sed
	sys-devel/gcc
	sys-devel/autoconf"

src_prepare() {
	# this is an admin application and really requires root to run correctly
	# we need to move the binary to the sbin directory
	sed -i s/bindir/sbindir/g source/Makefile.in || die
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc docs/sxid.{conf,cron}.example
}

pkg_postinst() {
	elog "You will need to configure sxid.conf for your system using the manpage and example"
}
