# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rake/rake-0.8.7-r2.ebuild,v 1.2 2009/12/15 06:54:12 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

inherit bash-completion ruby-fakegem

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

DESCRIPTION="Make-like scripting in Ruby"
HOMEPAGE="http://rake.rubyforge.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="bash-completion"

#ruby_add_bdepend test dev-ruby/flexmock

RESTRICT="test"

all_ruby_install() {
	ruby_fakegem_binwrapper rake

	if use doc; then
		pushd html
		dohtml -r *
		popd
	fi

	dodoc CHANGES README TODO || die
	doman doc/rake.1.gz || die

	dobashcompletion "${FILESDIR}"/rake.bash-completion rake
}
