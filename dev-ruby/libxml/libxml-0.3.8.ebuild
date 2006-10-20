# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/libxml/libxml-0.3.8.ebuild,v 1.3 2006/10/20 21:09:30 agriffis Exp $

inherit ruby gems

MY_P=${PN}-ruby-${PV}

DESCRIPTION="libxml for Ruby with a user friendly API, akin to REXML, but feature complete and significantly faster."
HOMEPAGE="http://libxml.rubyforge.org"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~hppa ia64 ~ppc ~sparc x86"
IUSE=""
USE_RUBY="ruby18 ruby19"

DEPEND="virtual/ruby
	>=dev-libs/libxml2-2.6.6"

#src_test() {
#	cd test
#	for i in *.rb ; do
#		ruby -rtest/unit $i || die "test $i failed."
#	done
#}
