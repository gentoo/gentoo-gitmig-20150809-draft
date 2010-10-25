# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facter/facter-1.5.8.ebuild,v 1.2 2010/10/25 02:09:25 jer Exp $

EAPI="2"
# jruby failed to install
USE_RUBY="ruby18 ruby19 ree18"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README* TODO"
RUBY_FAKEGEM_BINWRAP="facter"

inherit ruby-fakegem

DESCRIPTION="A cross-platform Ruby library for retrieving facts from operating systems"
HOMEPAGE="http://www.puppetlabs.com/puppet/related-projects/facter/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"

RUBY_PATCHES=( "${P}-freebsd-spec.patch" )

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"
