# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mhash/mhash-0.9.3-r1.ebuild,v 1.3 2006/04/22 22:39:21 flameeyes Exp $

inherit eutils

DESCRIPTION="library providing a uniform interface to a large number of hash algorithms"
HOMEPAGE="http://mhash.sourceforge.net/"
SRC_URI="mirror://sourceforge/mhash/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A} && cd "${S}"
	# for 0.9.3 only, please send patch upstream
	epatch "${FILESDIR}/${P}-mhash_free.patch"
}

src_compile() {
	econf \
		--enable-static \
		--enable-shared || die
	emake || die "make failure"
}

src_install() {
	dodir /usr/{bin,include,lib}
	make install DESTDIR="${D}" || die "install failure"

	dodoc AUTHORS INSTALL NEWS README TODO THANKS ChangeLog
	dodoc doc/*.txt doc/skid*
	prepalldocs
	cd doc && make mhash.html && dohtml mhash.html || die "dohtml failed"
}
