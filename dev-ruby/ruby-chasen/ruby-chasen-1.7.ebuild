# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-chasen/ruby-chasen-1.7.ebuild,v 1.3 2010/01/10 21:02:37 maekke Exp $

EAPI=2

inherit ruby

MY_P="chasen${PV}"
DESCRIPTION="ChaSen module for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=ruby-chasen"
SRC_URI="https://sites.google.com/a/ixenon.net/ruby-chasen/home/chasen1.7.tar.gz?attredirects=0 -> chasen-1.7.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=app-text/chasen-2.3.3-r2"

S="${WORKDIR}/${MY_P}"

RUBY_ECONF="${RUBY_ECONF} -L/usr/lib"
