# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gramadoir/gramadoir-0.2.ebuild,v 1.4 2004/04/07 10:36:30 taviso Exp $

DESCRIPTION="An Irish language grammar checker"
HOMEPAGE="http://borel.slu.edu/gramadoir/"
SRC_URI="http://borel.slu.edu/gramadoir/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 alpha"
IUSE=""

DEPEND=">=sys-apps/gawk-3.1.3
		>=sys-apps/diffutils-2.8.4
		>=sys-apps/sed-4
		>=app-arch/gzip-1.3.3
		>=sys-devel/flex-2.5.4
		>=sys-devel/bison-1.35"

RDEPEND=">=app-shells/bash-2.05b
		>=dev-lang/perl-5.8.0
		>=sys-apps/grep-2.5.1"

src_unpack() {
	unpack ${A}
	sed -i 's#@prefix@/libexec#@libexecdir@#g' ${S}/gr.in
}

src_compile() {
	econf --libexecdir=/usr/lib/gramadoir || die
	emake || die
}

src_install() {
	einstall libexecdir=${D}/usr/lib/gramadoir || die
	dodoc README COPYING triail triail.err
}
