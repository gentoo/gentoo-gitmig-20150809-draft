# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/text-format/text-format-0.64.ebuild,v 1.10 2006/10/20 21:32:08 agriffis Exp $

inherit eutils ruby

DESCRIPTION="Text::Format provides strong text formatting capabilities to Ruby"
HOMEPAGE="http://www.halostatue.ca/ruby/Text__Format.html"
SRC_URI="http://www.halostatue.ca/files/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""
DEPEND="virtual/ruby"
USE_RUBY="any"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-prefix.diff
}

src_compile() {
	return
}

src_install() {
	ruby install.rb --prefix=${D}/usr || die

	dohtml -r doc/*
	dodoc Changelog
}

src_test() {
	cd tests
	ruby unit_tests.rb || die "unit_tests.rb failed."
}
