# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/rakudo/rakudo-2009.12.ebuild,v 1.1 2010/01/08 20:45:18 patrick Exp $

EAPI=2

inherit eutils multilib

MY_PV="${PV/./-}"
MY_P="${PN}-${PV/./-}"
DESCRIPTION="A Perl 6 implementation built on the Parrot virtual machine"
HOMEPAGE="http://rakudo.org/"
SRC_URI="http://cloud.github.com/downloads/${PN}/${PN}/${MY_P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.8"
RDEPEND="~dev-lang/parrot-1.9.0
		 sys-libs/readline
		 sys-libs/ncurses"

src_configure() {
	cd "${MY_P}"
	perl Configure.pl || die "configure failed"
}

src_compile() {
	cd "${MY_P}"
	emake || die "make failed"
}

src_install() {
	cd "${MY_P}"
	emake install DESTDIR="${D}" || die "install failed"
}

src_test() {
	cd "${MY_P}"
	emake test || die "test failed"
}
