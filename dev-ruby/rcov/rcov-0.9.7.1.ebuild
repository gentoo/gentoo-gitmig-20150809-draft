# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcov/rcov-0.9.7.1.ebuild,v 1.2 2010/01/14 19:25:57 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="test_rcovrt"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="THANKS BLURB"

inherit ruby-fakegem versionator eutils

DESCRIPTION="A ruby code coverage analysis tool"
HOMEPAGE="http://eigenclass.org/hiki.rb?rcov"
SRC_URI="http://github.com/relevance/${PN}/tarball/release_$(replace_all_version_separators _) -> ${P}.tgz"

S="${WORKDIR}/relevance-${PN}-6f33de1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

# TODO: both emacs and vim support are present in this package, they
# should probably be added to the ebuild as well.
IUSE=""

# Tests are currently failing but upstream says it should be fine, I
# think it's a bug in their code but we'll see.
RESTRICT=test

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-jruby.patch

	# Without this change, testing will always cause the extension to
	# be rebuilt, and we don't want that.
	sed -i -e '/:test_rcovrt =>/s| => \[.*\]||' Rakefile || "Rakefile fix failed"

	# remove pre-packaged jar file (d'oh!)
	rm lib/rcovrt.jar || die
}

each_ruby_compile() {
	if [[ $(basename ${RUBY}) = "jruby" ]]; then
		${RUBY} -S rake lib/rcovrt.jar || die "build failed"
	else
		${RUBY} -S rake ext/rcovrt/rcovrt.so || die "build failed"
	fi
}

each_ruby_install() {
	each_fakegem_install

	if [[ $(basename ${RUBY}) != "jruby" ]]; then
		ruby_fakegem_newins ext/rcovrt/rcovrt.so lib/rcovrt.so
	fi
}
