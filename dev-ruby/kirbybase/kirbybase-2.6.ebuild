# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/kirbybase/kirbybase-2.6.ebuild,v 1.3 2009/09/22 13:42:06 maekke Exp $

inherit ruby gems

USE_RUBY="ruby18"
MY_P="KirbyBase-${PV}"

DESCRIPTION="A simple Ruby DBMS that stores data in plaintext files."
HOMEPAGE="http://www.netpromi.com/kirbybase_ruby.html"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 x86"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.2"
RDEPEND="${DEPEND}"
