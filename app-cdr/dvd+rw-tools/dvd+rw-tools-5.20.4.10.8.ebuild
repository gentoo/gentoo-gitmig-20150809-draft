# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/dvd+rw-tools/dvd+rw-tools-5.20.4.10.8.ebuild,v 1.1 2004/07/21 19:09:18 wschlich Exp $

DESCRIPTION="A set of tools for DVD+RW/-RW drives"
HOMEPAGE="http://fy.chalmers.se/~appro/linux/DVD+RW/"
SRC_URI="http://fy.chalmers.se/~appro/linux/DVD+RW/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64 ~alpha ~ia64"
IUSE=""

DEPEND="virtual/libc
	virtual/cdrtools"

src_compile() {
	sed -i -e "s:^CFLAGS=\$(WARN).*:CFLAGS=${CFLAGS}:" \
		-e "s:^CXXFLAGS=\$(WARN).*:CXXFLAGS=${CXXFLAGS} -fno-exceptions:" \
	Makefile.m4 || die
	emake || die
}

src_install() {
	dobin dvd+rw-booktype dvd+rw-format dvd+rw-mediainfo growisofs || die
	dohtml index.html
	doman growisofs.1
}
