# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubytter/rubytter-1.4.0.ebuild,v 1.1 2011/11/13 08:26:33 naota Exp $

EAPI="2"
# dev-ruby/oauth has only ruby18.
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Rubytter is a simple twitter library"
HOMEPAGE="http://wiki.github.com/jugyo/rubytter"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/json-1.1.3 >=dev-ruby/oauth-0.3.6"

each_ruby_install() {
	each_fakegem_install

	ruby_fakegem_doins VERSION || die
}
