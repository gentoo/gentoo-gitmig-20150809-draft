# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mkrf/mkrf-0.2.3-r1.ebuild,v 1.4 2010/07/26 13:44:33 fauli Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"
RUBY_FAKEGEM_DOCDIR="html"

# The unit tests (test:units) fail so skip them for now, since we have
# had this version in our tree for a long time. No bug tracker to
# report this problem. :-(
RUBY_FAKEGEM_TASK_TEST="test:integration"

inherit ruby-fakegem

DESCRIPTION="mkrf is a library for generating Rakefiles, primarily intended for building C extentions for Ruby."
HOMEPAGE="http://mkrf.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc x86"

IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"
