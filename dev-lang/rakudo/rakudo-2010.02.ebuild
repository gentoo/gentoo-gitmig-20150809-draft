# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/rakudo/rakudo-2010.02.ebuild,v 1.1 2010/02/28 20:58:59 lu_zero Exp $

EAPI=2

inherit eutils multilib

DESCRIPTION="A Perl 6 implementation built on the Parrot virtual machine"
HOMEPAGE="http://rakudo.org/"
SRC_URI="http://cloud.github.com/downloads/${PN}/${PN}/${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.10"
RDEPEND="~dev-lang/parrot-2.1.1
		 sys-libs/readline
		 sys-libs/ncurses"

src_configure() {
	perl Configure.pl || die "configure failed"
}
