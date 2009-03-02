# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/canny/canny-0.1.0.ebuild,v 1.8 2009/03/02 09:02:33 a3li Exp $

inherit ruby

IUSE=""
USE_RUBY="ruby18"

DESCRIPTION="Canny is a template library for Ruby."
HOMEPAGE="http://canny.sourceforge.net/"
SRC_URI="mirror://sourceforge/canny/${P}.tar.gz"

KEYWORDS="~amd64 ia64 ~ppc ppc64 x86"
LICENSE="LGPL-2.1"
SLOT="0"

src_compile() {
	ruby setup.rb config || die "setup.rb config failed"
	ruby setup.rb setup || die "setup.rb setup failed"
}

src_install() {
	ruby setup.rb config --prefix="${D}/usr" || die "setup.rb config failed"
	ruby setup.rb install || die "setup.rb install failed"
	dodoc ChangeLog README* example.rb templates/*
}
