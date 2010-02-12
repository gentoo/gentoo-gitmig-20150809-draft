# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amazon-ec2/amazon-ec2-0.9.3.ebuild,v 1.1 2010/02/12 21:25:02 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 jruby"

# dev-ruby/yard can be used instead of rdoc, but since the output only
# differs in style and adds one further dependency, we'll just go with
# rdoc for now.
#
# In case, the configuration would be
# RUBY_FAKEGEM_TASK_DOC="yard"
# RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc README_dev.rdoc ChangeLog"

RUBY_FAKEGEM_BINWRAP="ec2sh"

inherit ruby-fakegem eutils

DESCRIPTION="Library for accessing the Amazon Web Services EC2 and related"
HOMEPAGE="http://github.com/grempe/amazon-ec2"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend test "virtual/ruby-test-unit dev-ruby/test-spec dev-ruby/mocha"
ruby_add_rdepend '>=dev-ruby/xml-simple-1.0.12'

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-fixes.patch
}

each_ruby_prepare() {
	case ${RUBY} in
		*ruby19)
			;;
		*)
			# Remove the reference to test-unit gem, since it's only
			# available on Ruby 1.9.
			sed -i -e '/^gem/s:^:#:' test/test_helper.rb || die
			;;
	esac
}
