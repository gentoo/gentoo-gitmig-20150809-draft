# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /home/cvsroot/gentoo-x86/net-misc/rdate,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdate/rdate-990821-r1.ebuild,v 1.7 2003/07/28 16:23:12 gmsoft Exp $

inherit flag-o-matic

IUSE="ipv6"

DESCRIPTION="rdate uses the NTP server of your choice to syncronize/show the current time"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/network/misc/${P}.tar.gz"
HOMEPAGE="http://www.freshmeat.net/projects/rdate"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa"
LICENSE="GPL-2"

DEPEND=">=sys-apps/sed-4.0.5"

src_install(){
	use ipv6 && append-flags "-DINET6"

	sed -i "s/^\(CFLAGS = \).*/\1${CFLAGS}/" Makefile

	dodir /usr/{bin,share/man/man1}
	make DESTDIR=${D} install || die "Failed to install rdate"
	dodoc README.linux
}
