# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-fcgi/ruby-fcgi-0.8.5-r1.ebuild,v 1.3 2005/04/01 18:15:20 caleb Exp $

inherit ruby

DESCRIPTION="FastCGI library for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=fcgi"
SRC_URI="http://www.moonwolf.com/ruby/archive/${P}.tar.gz"

USE_RUBY="ruby16 ruby18 ruby19"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"
LICENSE="Ruby"

DEPEND="dev-libs/fcgi"

IUSE=""

PATCHES="${FILESDIR}/${PN}-leak.patch ${FILESDIR}/${PN}-sigabrt.patch"
