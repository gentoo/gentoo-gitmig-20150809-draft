# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gnuconfig/gnuconfig-20050223.ebuild,v 1.5 2005/03/22 13:19:32 gustavoz Exp $

inherit eutils

DESCRIPTION="Updated config.sub and config.guess file from GNU"
HOMEPAGE="ftp://ftp.gnu.org/pub/gnu/config"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc64 ~ppc-macos s390 sh sparc x86"
IUSE=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/config.guess.uclibc.patch
}

src_compile() { :;}

src_test() {
	make SHELL=/bin/sh check || die "make check failed :("
}

src_install() {
	insinto /usr/share/${PN}
	doins ChangeLog config.{sub,guess} || die
	fperms +x /usr/share/${PN}/config.{sub,guess}
}
