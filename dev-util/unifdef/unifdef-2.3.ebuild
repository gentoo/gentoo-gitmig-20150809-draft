# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/unifdef/unifdef-2.3.ebuild,v 1.8 2011/07/09 09:14:31 xarthisius Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="remove #ifdef'ed lines from a file while otherwise leaving the file alone"
HOMEPAGE="http://dotat.at/prog/unifdef/"
SRC_URI="http://dotat.at/prog/unifdef/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 -sparc-fbsd -x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

src_prepare() {
	sed -i 's:[.] version.sh:. ./version.sh:' reversion.sh || die
	sed -i '/^prefix/s:=.*:=/usr:' Makefile || die
	tc-export CC
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README
}
