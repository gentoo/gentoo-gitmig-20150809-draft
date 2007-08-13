# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mhash/mhash-0.9.9-r1.ebuild,v 1.3 2007/08/13 20:03:19 dertobi123 Exp $

inherit eutils

DESCRIPTION="library providing a uniform interface to a large number of hash algorithms"
HOMEPAGE="http://mhash.sourceforge.net/"
SRC_URI="mirror://sourceforge/mhash/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc ~sparc-fbsd ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	# Fix for issues in bug #181563
	unpack ${A} && cd "${S}"
	epatch "${FILESDIR}/${P}-mutils-align.patch"
}

src_compile() {
	econf \
		--enable-static \
		--enable-shared || die
	emake || die "make failure"
	cd doc && emake mhash.html || die "failed to build html"
}

src_install() {
	dodir /usr/{bin,include,lib}
	make install DESTDIR="${D}" || die "install failure"

	dodoc AUTHORS INSTALL NEWS README TODO THANKS ChangeLog
	dodoc doc/*.txt doc/skid* doc/*.c
	dohtml doc/mhash.html || die "dohtml failed"
}
