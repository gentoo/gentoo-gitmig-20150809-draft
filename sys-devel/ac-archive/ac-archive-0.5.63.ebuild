# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ac-archive/ac-archive-0.5.63.ebuild,v 1.1 2005/04/03 05:37:30 ka0ttic Exp $

inherit fixheadtails

DESCRIPTION="The Autoconf Macro Archive"
HOMEPAGE="http://ac-archive.sourceforge.net/"
SRC_URI="mirror://sourceforge/ac-archive/${P}.tar.bz2"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
	sys-devel/automake
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}
	ht_fix_file Makefile.in configure
}

src_compile() {
	econf || die
}

src_install() {
	make \
		install-aclocals \
		install-man \
		DESTDIR=${D} || die
	dodoc README TODO ChangeLog
	dohtml doc/*.htm
}
