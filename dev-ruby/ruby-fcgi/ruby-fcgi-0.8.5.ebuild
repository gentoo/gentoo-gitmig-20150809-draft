# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-fcgi/ruby-fcgi-0.8.5.ebuild,v 1.1 2005/02/01 08:04:44 usata Exp $

inherit ruby

DESCRIPTION="FastCGI library for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=fcgi"
SRC_URI="http://www.moonwolf.com/ruby/archive/${P}.tar.gz"

USE_RUBY="ruby16 ruby18 ruby19"
KEYWORDS="~x86 ~ppc"
LICENSE="Ruby"

DEPEND="dev-libs/fcgi"

IUSE=""

PATCHES="${FILESDIR}/${PN}-sigabrt.patch"
