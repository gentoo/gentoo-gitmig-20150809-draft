# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/cowsay/cowsay-3.03.ebuild,v 1.4 2004/03/21 01:41:20 mr_bones_ Exp $

DESCRIPTION="configurable talking ASCII cow (and other characters)"
HOMEPAGE="http://www.nog.net/~tony/warez/cowsay.shtml"
SRC_URI="http://www.nog.net/~tony/warez/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND=">=dev-lang/perl-5"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed	-i \
		-e '1 c\#!/usr/bin/perl'\
		-e 's/\$version/\$VERSION/g'\
		-e "s:%PREFIX%/share/cows:/usr/share/${P}/cows:" \
		-e '/getopts/ i\$Getopt::Std::STANDARD_HELP_VERSION=1;' cowsay \
			|| die "sed cowsay failed"
	sed -i \
		-e "s|%PREFIX%/share/cows|/usr/share/${P}/cows|" cowsay.1 \
			|| die "sed cowsay.1 failed"
}

src_install() {
	dobin cowsay || die "dobin failed"
	doman cowsay.1
	dosym cowsay /usr/bin/cowthink
	dosym cowsay.1.gz /usr/share/man/man1/cowthink.1.gz
	dodir "/usr/share/${P}"
	cp -r cows/ "${D}/usr/share/${P}/" || die "cp failed"
}
