# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bcm4400/bcm4400-1.0.1.ebuild,v 1.1 2003/01/19 03:50:31 sethbc Exp $

SRC_URI="http://www.nodomain.org/bcm4400-1.0.1.tar.gz"
DESCRIPTION="Driver for the bcm4400 gigabit card (in the form of kernel modules)."
HOMEPAGE="http:"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}/src

src_compile() {
    emake || die
}

src_install() {
    make PREFIX=${D} install || die
}


