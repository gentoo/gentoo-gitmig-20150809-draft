# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbweather/bbweather-0.6.ebuild,v 1.10 2005/01/18 15:46:14 ka0ttic Exp $

IUSE=""
DESCRIPTION="blackbox weather monitor"
HOMEPAGE="http://www.netmeister.org/apps/bbweather/"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa"

DEPEND="virtual/blackbox
	>=net-misc/wget-1.7
	>=dev-lang/perl-5.6.1"

src_install () {
	make DESTDIR=${D} install || die
	rm -rf ${D}/usr/share/doc
	dodoc README COPYING AUTHORS INSTALL ChangeLog NEWS TODO data/README.bbweather
	dohtml -r doc

	# since multiple bbtools packages provide this file, install
	# it in /usr/share/doc/${PF}
	mv ${D}/usr/share/bbtools/bbtoolsrc.in \
		${D}/usr/share/doc/${PF}/bbtoolsrc.example
}
