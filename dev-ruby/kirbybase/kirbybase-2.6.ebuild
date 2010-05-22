# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/kirbybase/kirbybase-2.6.ebuild,v 1.5 2010/05/22 15:21:51 flameeyes Exp $

inherit ruby gems

USE_RUBY="ruby18"
MY_P="KirbyBase-${PV}"

DESCRIPTION="A simple Ruby DBMS that stores data in plaintext files."
HOMEPAGE="http://www.netpromi.com/kirbybase_ruby.html"
SRC_URI="mirror://rubygems/${MY_P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ia64 ~ppc64 x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2"
RDEPEND="${DEPEND}"
