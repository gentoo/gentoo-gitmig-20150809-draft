# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/umodpack/umodpack-0.5_beta16-r1.ebuild,v 1.1 2005/05/09 04:55:02 vapier Exp $

inherit perl-module toolchain-funcs

MY_P=${P/_beta/b}
DESCRIPTION="portable and useful [un]packer for Unreal Tournament's Umod files"
HOMEPAGE="http://umodpack.sourceforge.net/"
SRC_URI="http://umodpack.sourceforge.net/${MY_P}-allinone.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X"

DEPEND="dev-lang/perl
	dev-perl/Archive-Zip
	dev-perl/Tie-IxHash
	X? ( virtual/x11 dev-perl/perl-tk )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# remove the stupid perl modules since we already installed em
	rm -rf {Archive-Zip,Compress-Zlib,Tie-IxHash,Tk}*
}

src_compile() {
	perl-module_src_compile

	cd umr-0.3
	emake DEBUG=0 CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "umr build failed"
}

src_install() {
	mydoc="Changes"
	perl-module_src_install
	dobin umod umr-0.3/umr || die "umod/umr failed"
	if use X ; then
		dobin xumod || die "xumod failed"
	fi
}
