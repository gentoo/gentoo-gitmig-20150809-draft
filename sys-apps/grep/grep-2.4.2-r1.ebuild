# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.4.2-r1.ebuild,v 1.4 2000/10/03 16:02:04 achim Exp $

P=grep-2.4.2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU regular expression matcher"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/grep/${A}
	 ftp://prep.ai.mit.edu/gnu/grep/${A}"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"

src_compile() {                           
	try ./configure --prefix=/usr --host=${CHOST}
	try make
}

src_install() {                               
	into /usr
	dobin src/grep src/egrep src/fgrep
	doinfo doc/grep.info
	doman doc/*.1
	MOPREFIX=grep
	domo po/*.po
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog NEWS README THANKS TODO
}



