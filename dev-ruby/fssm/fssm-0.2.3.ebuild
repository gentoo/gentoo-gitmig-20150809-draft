# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fssm/fssm-0.2.3.ebuild,v 1.1 2011/01/09 15:42:57 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.markdown"

RUBY_FAKEGEM_EXTRAINSTALL="VERSION.yml"

inherit ruby-fakegem

DESCRIPTION="Monitor API"
HOMEPAGE="http://github.com/ttilley/fssm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

each_ruby_prepare() {
	# Remove check_dependencies task so we don't have to depend on jeweler.
	sed -i -e '/check_dependencies/d' Rakefile || die
}
