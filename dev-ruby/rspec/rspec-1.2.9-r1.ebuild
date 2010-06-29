# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rspec/rspec-1.2.9-r1.ebuild,v 1.6 2010/06/29 10:39:53 angelos Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="A Behaviour Driven Development (BDD) framework for Ruby"
HOMEPAGE="http://rspec.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT=test

all_ruby_install() {
	for bin in spec autospec; do
		ruby_fakegem_binwrapper $bin
	done

	dodoc History.rdoc README.rdoc TODO.txt Ruby1.9.rdoc Upgrade.rdoc || die
}
