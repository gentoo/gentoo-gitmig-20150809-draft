# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ac-archive/ac-archive-0.5.57.ebuild,v 1.1 2004/07/18 06:32:40 vapier Exp $

inherit fixheadtails

DESCRIPTION="The Autoconf Macro Archive"
HOMEPAGE="http://ac-archive.sourceforge.net/"
SRC_URI="mirror://sourceforge/ac-archive/${P}.tar.bz2"

LICENSE="BSD | GPL-2"
SLOT="0"
KEYWORDS="~x86"
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
}
