# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ktoblzcheck/ktoblzcheck-0.7.ebuild,v 1.4 2004/06/08 01:19:54 dragonheart Exp $

DESCRIPTION="Library to check account numbers and bank codes of German banks"
HOMEPAGE="http://ktoblzcheck.sourceforge.net/"
SRC_URI="mirror://sourceforge/ktoblzcheck/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/grep
	sys-devel/libtool
	sys-devel/gcc"

src_install() {
	emake DESTDIR=${D} || die "install failed"
}

src_test() {
	cd ${S}/src/bin/
	./check_ktoblzcheck || die "self check of accounts failed"
}
