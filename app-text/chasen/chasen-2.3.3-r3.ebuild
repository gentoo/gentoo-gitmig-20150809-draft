# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/chasen/chasen-2.3.3-r3.ebuild,v 1.10 2006/07/10 05:28:58 usata Exp $

inherit perl-app eutils

DESCRIPTION="Japanese Morphological Analysis System, ChaSen"
HOMEPAGE="http://chasen.aist-nara.ac.jp/"
SRC_URI="http://chasen.aist-nara.ac.jp/stable/chasen/${P}.tar.gz"

LICENSE="chasen"
SLOT="0"
KEYWORDS="x86 amd64 sparc ppc"
IUSE="perl"

RDEPEND=">=dev-libs/darts-0.2
	perl? ( !dev-perl/Text-ChaSen )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"
PDEPEND=">=app-dicts/ipadic-2.6.1"

src_unpack() {
	unpack ${A}

	if use perl ; then
		cd ${S}/perl
		sed -i -e '5a"LD" => "g++",' Makefile.PL || die
	fi
	cd ${S}
	epatch ${FILESDIR}/chasen-2.4.0_pre1-gcc34.patch
	if has_version '>=dev-libs/darts-0.3' ; then
		epatch "${FILESDIR}"/${P}-darts-0.3.patch
	fi
}

src_compile() {
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
