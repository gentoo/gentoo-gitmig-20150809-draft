# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/diaria/diaria-0.1.4.ebuild,v 1.1 2004/01/31 09:10:07 usata Exp $

inherit ruby

DESCRIPTION="Diaria is for posting news items to the web. "
HOMEPAGE="http://rubyforge.org/projects/diaria/"
SRC_URI="http://rubyforge.org/download.php/208/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
USE_RUBY="any"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/ruby-1.8.0"

src_compile() {
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb install || die
	insinto /usr/share/diaria/templates
	doins share/diaria/templates/*
	dodoc share/diaria/doc/*.txt share/diaria/doc/config.sample
	dohtml share/diaria/doc/*
}
