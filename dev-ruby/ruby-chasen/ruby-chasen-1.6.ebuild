# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-chasen/ruby-chasen-1.6.ebuild,v 1.5 2006/11/05 16:53:10 usata Exp $

inherit ruby

MY_P="chasen${PV}"
DESCRIPTION="ChaSen module for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=ruby-chasen"
SRC_URI="http://www.itlb.te.noda.sut.ac.jp/~ikarashi/ruby/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE=""

DEPEND="virtual/ruby
	>=app-text/chasen-2.3.3-r2"

S="${WORKDIR}/${MY_P}"

RUBY_ECONF="${RUBY_ECONF} -L/usr/lib"
