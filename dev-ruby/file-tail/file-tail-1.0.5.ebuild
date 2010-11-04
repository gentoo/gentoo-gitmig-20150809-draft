# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/file-tail/file-tail-1.0.5.ebuild,v 1.2 2010/11/04 17:30:17 fauli Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"

inherit ruby-fakegem

DESCRIPTION="A small ruby library that allows it to 'tail' files in Ruby"
HOMEPAGE="http://flori.github.com/file-tail"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/spruz"
ruby_add_bdepend "test? ( virtual/ruby-test-unit ) "
