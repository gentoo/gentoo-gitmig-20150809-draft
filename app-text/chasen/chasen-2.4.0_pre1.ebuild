# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/chasen/chasen-2.4.0_pre1.ebuild,v 1.1 2004/09/07 08:31:10 usata Exp $

inherit perl-module flag-o-matic

MY_P="${P/_pre/-preview}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Japanese Morphological Analysis System, ChaSen"
HOMEPAGE="http://chasen.aist-nara.ac.jp/"
SRC_URI="http://chasen.aist-nara.ac.jp/stable/chasen/${MY_P}.tar.gz"

LICENSE="chasen"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="perl"

DEPEND=">=dev-libs/darts-0.2"
PDEPEND=">=app-dicts/ipadic-2.6.1"

src_unpack() {
	unpack ${A}

	if use perl ; then
		cd ${S}/perl
		sed -i -e '5a"LD" => "g++",' Makefile.PL || die
	fi
}

src_compile() {
	# Unconditional use of -fPIC (#55238)
	append-flags -fPIC
	econf || die
	emake || die
	if use perl ; then
		cd ${S}/perl
		perl-module_src_compile
	fi
}

src_install () {
	einstall || die

	if use perl ; then
		cd ${S}/perl
		perl-module_src_install
	fi

	cd ${S}
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
