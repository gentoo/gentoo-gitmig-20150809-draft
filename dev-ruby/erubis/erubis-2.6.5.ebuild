# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/erubis/erubis-2.6.5.ebuild,v 1.4 2010/06/30 06:43:11 fauli Exp $

EAPI="2"

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Erubis is an implementation of eRuby"
HOMEPAGE="http://www.kuwata-lab.com/erubis/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"
ruby_add_rdepend ">=dev-ruby/abstract-1.0.0"

each_ruby_prepare() {
	# Fix case so that the associated test will work. Reported as http://rubyforge.org/tracker/index.php?func=detail&aid=27330&group_id=1320&atid=5201
	mv test/data/users-guide/Example.ejava test/data/users-guide/example.ejava || die
}

each_ruby_test() {
	PATH="${S}/bin:${PATH}" RUBYLIB="${S}/lib" ${RUBY} test/test.rb || die
}
