# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-fcgi/ruby-fcgi-0.8.6.ebuild,v 1.9 2008/11/30 14:19:55 graaff Exp $

inherit ruby

DESCRIPTION="FastCGI library for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=fcgi"
SRC_URI="http://sugi.nemui.org/pub/ruby/fcgi/${P}.tar.gz"

USE_RUBY="ruby18"
KEYWORDS="amd64 ia64 ppc sparc x86 ~x86-fbsd"
LICENSE="Ruby"

DEPEND="dev-libs/fcgi"

IUSE=""
