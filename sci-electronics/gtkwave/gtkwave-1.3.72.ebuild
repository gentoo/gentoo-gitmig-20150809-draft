# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gtkwave/gtkwave-1.3.72.ebuild,v 1.4 2006/01/17 20:23:03 plasmaroo Exp $

inherit eutils

DESCRIPTION="A wave viewer for LXT and Verilog VCD/EVCD files"
HOMEPAGE="http://home.nc.rr.com/gtkwave/"
SRC_URI="mirror://gentoo/gtkwave-1.3.72.tar.gz"

IUSE=""
LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2
	app-arch/bzip2"

#S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	econf || die
	sed -i -e "s/mandir = /mandir = \${prefix}/" ${S}/Makefile
	emake || die
}

src_install() {
	emake prefix=${D} install || die
	dodoc AUTHORS ChangeLog README
	dohtml -r doc/*
	mv ${D}/bin ${D}/usr/bin
}
