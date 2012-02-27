# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nagios_analyzer/nagios_analyzer-0.0.3.ebuild,v 1.1 2012/02/27 18:26:34 a3li Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_EXTRADOC="README.textile"

inherit ruby-fakegem

DESCRIPTION="A simple parser for Nagios status files"
HOMEPAGE="https://github.com/jbbarth/nagios_analyzer"
LICENSE="as-is"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="${RDEPEND}"
DEPEND="${DEPEND}"

ruby_add_bdepend "test? ( dev-ruby/rspec )"

each_ruby_test() {
	rspec ./spec/section_spec.rb ./spec/status_spec.rb
}
