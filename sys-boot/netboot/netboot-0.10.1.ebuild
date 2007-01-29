# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/netboot/netboot-0.10.1.ebuild,v 1.1 2007/01/29 08:00:12 dragonheart Exp $

inherit eutils toolchain-funcs

DESCRIPTION="netbooting utility"
HOMEPAGE="http://netboot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/lzo-2
		>=sys-libs/db-4"
RDEPEND="${DEPEND}
		!net-misc/mknbi"


src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-nossp.patch
	epatch "${FILESDIR}"/${P}-destdir.patch
	sed -i -e "s/-s$//" "${S}"/make.config.in
}

src_compile() {
#	export GCC86DEBUG="-fno-pie -fno-stack-protector"
	econf --enable-bootrom --with-gnu-cc86="$(tc-getCC)" \
		--with-gnu-as86="$(tc-getAS)" --with-gnu-ld86="$(tc-getLD)"|| die 'cannot configure'
	# --enable-config-file
	sed -i -e "s/-llzo/-llzo2/" "${S}"/make.config
	emake  -j1 || die 'cannot make'
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc README doc/*
	docinto FlashCard
	dodoc FlashCard/README FlashCard/*.ps
	mv "${D}"/usr/share/misc "${D}"/usr/share/${PN}
	rm -rf "${D}"/usr/lib/netboot/utils

	dobin "${S}"/mknbi-dos/utils/mntnbi.pl

	insinto /usr/share/vim/vimfiles/syntax
	doins "${S}"/mknbi-mgl/misc/mgl.vim
}
