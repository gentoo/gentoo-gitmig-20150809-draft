# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/muttprint/muttprint-0.71.ebuild,v 1.7 2004/01/09 23:27:33 agriffis Exp $

DESCRIPTION="Script for pretty printing of your mails"
HOMEPAGE="http://muttprint.sf.net/"
SRC_URI="mirror://sourceforge/muttprint/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha"

DEPEND="virtual/tetex
	dev-perl/TimeDate"

src_compile() {

	if has_version 'app-text/ptex' ; then
		cp muttprint muttprint.in
		sed -e "s/latex/platex/g" muttprint.in > muttprint
	fi
}

src_install() {
	make prefix=${D}/usr docdir=${D}/usr/share/doc docdirname=${P} install
}
