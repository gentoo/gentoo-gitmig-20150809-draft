# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/bbweather/bbweather-0.3.ebuild,v 1.3 2001/08/15 19:25:28 lordjoe Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="blackbox weather monitor"
SRC_URI="http://www.netmeister.org/apps/${A}"
HOMEPAGE="http://www.netmeister.org/apps/bbweather/index.html"

DEPEND=">=x11-wm/blackbox-0.61
	>=net-misc/wget-1.7
	>=sys-devel/perl-5.6.1"

src_compile() {

	try ./configure --prefix=/usr/X11R6 --host=${CHOST}
	try emake

}

src_install () {

	try make DESTDIR=${D} install
	dodoc README COPYING AUTHORS INSTALL ChangeLog NEWS TODO data/README.bbweather
}

