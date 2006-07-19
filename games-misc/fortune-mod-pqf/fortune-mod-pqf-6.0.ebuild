# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-pqf/fortune-mod-pqf-6.0.ebuild,v 1.6 2006/07/19 19:56:24 flameeyes Exp $

DESCRIPTION="Fortune database of Terry Pratchett's Discworld related quotes"
HOMEPAGE="http://www.lspace.org/"
SRC_URI="http://www.ie.lspace.org/ftp-lspace/words/pqf/pqf-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/${A} "${S}"/pqf-${PV}
}

src_compile() {
	uniq "pqf-${PV}" | sed 's/^$/\%/g' > pqf
	echo "%" >> pqf
	rm "pqf-${PV}"
	strfile -r pqf || die
}

src_install() {
	insinto /usr/share/fortune
	doins pqf pqf.dat || die
}
