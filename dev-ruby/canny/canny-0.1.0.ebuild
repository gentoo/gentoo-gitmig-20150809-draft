# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/canny/canny-0.1.0.ebuild,v 1.4 2006/03/30 03:23:47 agriffis Exp $

inherit ruby

IUSE=""
USE_RUBY="any"

DESCRIPTION="Canny is a template library for Ruby."
HOMEPAGE="http://canny.sourceforge.net/"
SRC_URI="mirror://sourceforge/canny/${P}.tar.gz"

KEYWORDS="~ia64 ~ppc x86"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="virtual/ruby"

src_compile() {
	ruby setup.rb config || die "setup.rb config failed"
	ruby setup.rb setup || die "setup.rb setup failed"
}

src_install() {
	ruby setup.rb config --prefix=${D}/usr || die "setup.rb config failed"
	ruby setup.rb install || die "setup.rb install failed"
	dodoc COPYING ChangeLog README* example.rb templates/*
}
