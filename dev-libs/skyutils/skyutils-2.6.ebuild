# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/skyutils/skyutils-2.6.ebuild,v 1.1 2004/04/18 01:35:51 dragonheart Exp $

IUSE="ssl"

DESCRIPTION="Library of assorted C utility functions."
HOMEPAGE="http://zekiller.skytech.org/coders_en.html"
SRC_URI="http://zekiller.skytech.org/fichiers/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="virtual/glibc
	sys-apps/gawk
	sys-devel/gcc
	ssl? ( dev-libs/openssl )"

RDEPEND="virtual/glibc"

src_compile() {
	econf `use_enable ssl` || die "./configure failed"
	emake || die
}

src_install () {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL License.txt NEWS README
}
