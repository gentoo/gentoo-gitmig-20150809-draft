# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/plptools/plptools-0.13.ebuild,v 1.1 2005/08/17 12:52:57 greg_g Exp $

inherit kde-functions eutils

DESCRIPTION="Libraries and utilities to communicate with a Psion palmtop via serial."
HOMEPAGE="http://plptools.sourceforge.net"
SRC_URI="mirror://sourceforge/plptools/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
DEPEND="kde? ( >=kde-base/kdelibs-3.1 )
	readline? ( sys-libs/readline )"

IUSE="kde nls readline"

src_unpack() {
	unpack ${A}

	# Applied in next versions.
	epatch "${FILESDIR}/${P}-gcc.patch"
}

src_compile() {
	set-kdedir 3

	local myconf="$(use_enable kde)
	              $(use_enable nls)
	              $(use_enable readline)
	              $(use_enable readline history)
	              --disable-newt"

	econf ${myconf} || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc CHANGES ChangeLog README TODO

	insinto /etc/conf.d
	newins ${FILESDIR}/psion.conf psion

	exeinto /etc/init.d
	doexe ${FILESDIR}/psion
}
