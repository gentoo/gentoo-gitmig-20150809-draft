# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gibbler/gibbler-0.7.7.ebuild,v 1.1 2010/04/04 18:08:44 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Git-like hashes for Ruby objects"
HOMEPAGE="http://solutious.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/attic-0.4.0"

#ruby_add_bdepend test dev-ruby/tryouts

# Tests currenty fail for all implementations
# http://github.com/delano/gibbler/issues/issue/1
RESTRICT=test

# Tests are not in the released gem, but since we don't run them we
# don't need the whole sources as it is.

#SRC_URI="http://github.com/delano/${PN}/tarball/${P} -> ${PN}-git-${PV}.tgz"
#S="${WORKDIR}/delano-${PN}-${whatever}"

each_ruby_test() {
	${RUBY} -S sergeant || die "tests failed"
}
