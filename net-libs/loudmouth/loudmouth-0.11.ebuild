# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-0.11.ebuild,v 1.1 2003/07/17 02:13:41 rizzo Exp $

DESCRIPTION="Loudmouth is a lightweight and easy-to-use C library for programming with the Jabber protocol. It's designed to be easy to get started with and yet extensible to let you do anything the Jabber protocol allows."
HOMEPAGE="http://www.imendio.com/projects/loudmouth/"
SRC_URI="http://www.imendio.com/projects/loudmouth/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
