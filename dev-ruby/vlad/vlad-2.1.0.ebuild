# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/vlad/vlad-2.1.0.ebuild,v 1.2 2010/08/18 11:14:27 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="considerations.txt History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Pragmatic application deployment automation, without mercy."
HOMEPAGE="http://rubyhitsquad.com/Vlad_the_Deployer.html"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "dev-ruby/hoe test? ( dev-ruby/minitest )"
ruby_add_rdepend ">=dev-ruby/open4-0.9.0 >=dev-ruby/rake-remote_task-2.0.0"

ruby_all_install() {
	ruby_fakegem_install

	dodoc doco/* || die
}
