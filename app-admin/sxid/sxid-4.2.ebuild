# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sxid/sxid-4.2.ebuild,v 1.1 2011/07/26 21:29:28 xmw Exp $

EAPI=3

inherit base toolchain-funcs

DESCRIPTION="suid, sgid file and directory checking"
SRC_URI="http://linukz.org/download/${P}.tar.gz"
HOMEPAGE="http://freshmeat.net/projects/sxid"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="virtual/mailx"
DEPEND="sys-apps/sed
	sys-devel/gcc
	sys-devel/autoconf"

PATCHES=( "${FILESDIR}/${PN}-64bit-clean.patch" )

src_prepare() {
	# this is an admin application and really requires root to run correctly
	# we need to move the binary to the sbin directory
	sed -i s/bindir/sbindir/g source/Makefile.in
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc docs/{sxid.{conf,cron}.example,TODO} || die
}

pkg_postinst() {
	elog "You will need to configure sxid.conf for your system using the manpage and example"
}
