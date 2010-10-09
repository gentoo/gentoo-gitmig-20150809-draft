# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pdf-reader/pdf-reader-0.8.6.ebuild,v 1.2 2010/10/09 08:39:02 graaff Exp $

EAPI=2

GITHUB_USER=yob

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc TODO"

inherit ruby-fakegem

DESCRIPTION="PDF parser conforming as much as possible to the PDF specification from Adobe"
HOMEPAGE="http://github.com/yob/pdf-reader/"

# We cannot use the gem distributions because they don't contain the
# tests' data, we have to rely on the git tags.
SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/v${PV} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/${GITHUB_USER}-${PN}-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend dev-ruby/ascii85

# rspec is loaded even during doc generation, so keep it around :(
ruby_add_bdepend "dev-ruby/rake dev-ruby/rspec:0"

all_ruby_prepare() {
	# Avoid forcing rcov on, this also seem to resolve a problem in
	# tests with US_ASCII encoding.
	sed -i \
		-e '/rcov/s:true:false:' \
		Rakefile || die "Rakefile fix failed"
}

each_ruby_test() {
	case ${RUBY} in
		*jruby)
			eqawarn "jruby tests hang, reported upstream."
			;;
		*)
			each_fakegem_test
			;;
	esac
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die
}
