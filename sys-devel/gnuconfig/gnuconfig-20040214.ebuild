# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gnuconfig/gnuconfig-20040214.ebuild,v 1.14 2004/11/12 14:11:59 vapier Exp $

inherit eutils

DESCRIPTION="Updated config.sub and config.guess file from GNU"
HOMEPAGE="ftp://ftp.gnu.org/pub/gnu/config"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE="uclibc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-20040312-update.patch
	use uclibc && epatch ${FILESDIR}/automake-1.8.5-config-guess-uclibc.patch
}

src_install() {
	insinto /usr/share/${PN}
	doins ${WORKDIR}/{ChangeLog,config.{sub,guess}} || die
	fperms +x /usr/share/${PN}/config.{sub,guess}
}
