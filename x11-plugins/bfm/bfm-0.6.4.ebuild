# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/bfm/bfm-0.6.4.ebuild,v 1.1 2004/11/12 23:46:51 s4t4n Exp $

inherit eutils

IUSE=""

DESCRIPTION="Dock application that combines timecop's bubblemon and wmfishtime together."
HOMEPAGE="http://www.jnrowe.ukfsn.org/projects/bfm.html"
SRC_URI="http://www.jnrowe.ukfsn.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/gtk+-2.4.9-r1"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Patch to honour Gentoo CFLAGS
	epatch ${FILESDIR}/${P}-Makefile.patch
}

src_compile()
{
	emake GENTOO_CFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install ()
{
	dodoc ChangeLog README doc/Xdefaults.sample README.bubblemon
	einstall PREFIX="${D}/usr" || die "Installation failed"
}
