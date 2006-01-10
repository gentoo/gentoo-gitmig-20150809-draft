# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-fcgi/ruby-fcgi-0.8.6.ebuild,v 1.3 2006/01/10 17:24:51 fmccor Exp $

inherit ruby

DESCRIPTION="FastCGI library for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=fcgi"
SRC_URI="http://sugi.nemui.org/pub/ruby/fcgi/${P}.tar.gz"

USE_RUBY="ruby16 ruby18 ruby19"
KEYWORDS="~amd64 ~ppc sparc x86"
LICENSE="Ruby"

DEPEND="dev-libs/fcgi"

IUSE=""
