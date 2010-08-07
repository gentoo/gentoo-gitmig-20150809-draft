# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mixlib-authentication/mixlib-authentication-1.1.4.ebuild,v 1.1 2010/08/07 13:00:43 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="NOTICE README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Mixes in simple per-request authentication"
HOMEPAGE="http://github.com/opscode/mixlib-authentication"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Tests fail. Not clear if this is a regression since the previous
# ebuild did not run tests. No upstream bug tracker to report the
# failure to.
RESTRICT="test"

ruby_add_bdepend "test? ( dev-ruby/rspec )"

ruby_add_rdepend "dev-ruby/mixlib-log"
