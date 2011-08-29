# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chrpath/chrpath-0.13-r2.ebuild,v 1.1 2011/08/29 19:23:22 hwoarang Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="chrpath can modify the rpath and runpath of ELF executables"
HOMEPAGE="http://directory.fsf.org/project/chrpath/"
# original upstream no longer exists (ftp://ftp.hungry.com/pub/hungry)
SRC_URI="http://ftp.tux.org/pub/X-Windows/ftp.hungry.com/chrpath/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-multilib.patch
	epatch "${FILESDIR}"/${PN}-keepgoing.patch
	epatch "${FILESDIR}"/${P}-testsuite-1.patch
	sed -i -e '/^docdir/d' Makefile.am # use standard docdir
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog AUTHORS NEWS README
}
