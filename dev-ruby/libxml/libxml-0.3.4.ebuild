# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/libxml/libxml-0.3.4.ebuild,v 1.3 2005/08/05 19:39:58 hansmi Exp $

inherit ruby

DESCRIPTION="libxml for Ruby with a user friendly API, akin to REXML, but feature complete and significantly faster."
HOMEPAGE="http://raa.ruby-lang.org/project/libxml/"
SRC_URI="http://www.rubynet.org/modules/xml/libxml/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"

DEPEND="virtual/ruby
	>=dev-libs/libxml2-2.6.6"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	erubydoc
}

src_test() {
	cd test
	for i in *.rb ; do
		ruby -rtest/unit $i || die "test $i failed."
	done
}
