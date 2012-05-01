# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/httpclient/httpclient-2.1.5.2-r1.ebuild,v 1.11 2012/05/01 18:24:15 armin76 Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="-Ilib test"
RUBY_FAKEGEM_TASK_DOC="-Ilib doc"

RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_EXTRADOC="README.txt"

inherit ruby-fakegem

DESCRIPTION="'httpclient' gives something like the functionality of libwww-perl (LWP) in Ruby"
HOMEPAGE="http://dev.ctor.org/http-access2/"
SRC_URI="http://dev.ctor.org/download/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"

KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND="${RDEPEND}
	!dev-ruby/http-access2"

RESTRICT="test"

# tests are known to fail, but at least they fail for all
# implementations in the same way.
ruby_add_bdepend "test? ( virtual/ruby-test-unit )"
