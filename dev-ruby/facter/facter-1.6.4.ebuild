# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facter/facter-1.6.4.ebuild,v 1.3 2012/01/01 21:06:08 grobian Exp $

EAPI="4"

USE_RUBY="ruby18 ruby19 ree18 jruby"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.md"
RUBY_FAKEGEM_BINWRAP="facter"

inherit ruby-fakegem

DESCRIPTION="A cross-platform Ruby library for retrieving facts from operating systems"
HOMEPAGE="http://www.puppetlabs.com/puppet/related-projects/facter/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="${RDEPEND}
	sys-apps/dmidecode
	sys-apps/lsb-release
	sys-apps/pciutils"

ruby_add_bdepend "test? (
		dev-ruby/mocha
		dev-ruby/rspec:2
	)"
