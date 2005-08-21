# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/hap/hap-3.7-r1.ebuild,v 1.1 2005/08/21 10:39:30 ferdy Exp $

IUSE=""

DESCRIPTION="A terminal mail notification program (replacement for biff)"
HOMEPAGE="http://www.transbay.net/~enf/sw.html"
SRC_URI="http://www.transbay.net/~enf/hap-3.7.tar"

DEPEND="sys-libs/ncurses
	sys-devel/autoconf"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~ppc ~x86"

# untars to 'hap/'
S="${WORKDIR}/${PN}"

src_compile() {
	# Fix configure to use ncurses instead of termcap (bug #103105)
	sed -i -e '/AC_CHECK_LIB/s~termcap~ncurses~' configure.in

	# Fix Makefile.in to use our CFLAGS
	sed -i -e "/^CFLAGS=-O/s//CFLAGS=${CFLAGS}/" Makefile.in

	# Rebuild the compilation framework
	autoconf || die "autoconf failed"

	# The configure script doesn't like --mandir etc., so we call it directly
	# rather than via econf
	./configure || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	dobin hap
	doman hap.1
}
