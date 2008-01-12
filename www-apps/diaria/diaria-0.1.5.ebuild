# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/diaria/diaria-0.1.5.ebuild,v 1.1 2008/01/12 07:42:22 graaff Exp $

inherit ruby

DESCRIPTION="Diaria is for posting news items to the web. "
HOMEPAGE="http://rubyforge.org/projects/diaria/"
SRC_URI="http://rubyforge.org/download.php/296/${P}.tar.gz"
LICENSE="LGPL-2.1"
USE_RUBY="any"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/ruby"

src_compile() {
	ruby install.rb config --prefix="${D}/usr" || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb install || die
	insinto /usr/share/diaria/templates
	doins share/diaria/templates/*
	dodoc share/diaria/doc/*.txt share/diaria/doc/config.sample
	dohtml share/diaria/doc/*
}
