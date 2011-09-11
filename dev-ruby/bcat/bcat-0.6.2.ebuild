# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bcat/bcat-0.6.2.ebuild,v 1.1 2011/09/11 05:51:27 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC="man"
RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="A pipe to browser utility for use at the shell and within editors like Vim or Emacs."
HOMEPAGE="http://github.com/rtomayko/bcat"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "doc? ( app-text/ronn )"
ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend "dev-ruby/rack"

all_ruby_install() {
	all_fakegem_install

	doman man/*.1
}
