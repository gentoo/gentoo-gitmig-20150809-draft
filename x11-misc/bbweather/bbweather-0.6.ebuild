# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbweather/bbweather-0.6.ebuild,v 1.3 2004/04/05 13:56:34 zx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="blackbox weather monitor"
HOMEPAGE="http://www.netmeister.org/apps/bbweather/"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa"

DEPEND="virtual/blackbox
	>=net-misc/wget-1.7
	>=dev-lang/perl-5.6.1"

src_install () {

	make DESTDIR=${D} install || die
	rm -rf ${D}/usr/share/doc
	dodoc README COPYING AUTHORS INSTALL ChangeLog NEWS TODO data/README.bbweather
	dohtml -r doc
}
