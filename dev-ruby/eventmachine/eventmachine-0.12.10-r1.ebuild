# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/eventmachine/eventmachine-0.12.10-r1.ebuild,v 1.1 2009/12/27 19:49:50 a3li Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="docs/ChangeLog README"

inherit ruby-fakegem

DESCRIPTION="EventMachine is a fast, simple event-processing library for Ruby programs."
HOMEPAGE="http://rubyeventmachine.com"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="examples"

ruby_add_bdepend 'dev-ruby/rake'

all_ruby_prepare() {
	# This test only works on BSD, and error handling fails on 1.8
	rm tests/test_process_watch.rb || die "rm failed"
}

each_ruby_compile() {
	${RUBY} /usr/bin/rake build || die "rake build failed"
}

all_ruby_install() {
	all_fakegem_install

	use examples || return

	insinto /usr/share/doc/${PF}/
	doins -r examples || die "Failed to install examples"
}
