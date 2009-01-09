# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/remind/remind-03.01.06.ebuild,v 1.3 2009/01/09 22:28:27 josejx Exp $

MY_P=${P/_beta/-BETA-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Ridiculously functional reminder program"
HOMEPAGE="http://www.roaringpenguin.com/products/remind"
SRC_URI="http://www.roaringpenguin.com/files/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE="tk"

RDEPEND="tk? ( dev-lang/tk dev-tcltk/tcllib )"

src_unpack() {
	unpack ${A}
	sed -i 's:$(MAKE) install:&-nostripped:' "${S}"/Makefile || die
}

src_test() {
	if [[ $UID -eq 0 ]] ; then
		ewarn "Testing fails if run as root. Skipping tests."
		return
	fi
	make test || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dobin www/rem2html || die "dobin failed"

	dodoc docs/WHATSNEW examples/defs.rem www/README.* || die "dodoc failed"

	if ! use tk ; then
		rm "${D}"/usr/bin/tkremind "${D}"/usr/share/man/man1/tkremind* \
			"${D}"/usr/bin/cm2rem*  "${D}"/usr/share/man/man1/cm2rem*
	fi
}
