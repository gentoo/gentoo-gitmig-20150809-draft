# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rack/rack-1.0.1-r2.ebuild,v 1.3 2011/05/31 20:22:35 maekke Exp $

EAPI="3"
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="ChangeLog KNOWN-ISSUES README SPEC"

inherit ruby-fakegem eutils versionator

DESCRIPTION="A modular Ruby webserver interface"
HOMEPAGE="http://rubyforge.org/projects/rack"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

# The gem has automagic dependencies over mongrel, ruby-openid,
# memcache-client, thin, mongrel and camping; not sure if we should
# make them dependencies at all.
ruby_add_bdepend test dev-ruby/test-spec

# Block against versions in older slots that also try to install a binary.
RDEPEND="${RDEPEND} !<dev-ruby/rack-1.1.0-r1:0"

#USE_RUBY=ruby19 \
#	ruby_add_bdepend "ruby_targets_ruby19 test" '=dev-ruby/test-unit-1*'

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

each_ruby_test() {
	# Since the Rakefile calls specrb directly rather than loading it, we
	# cannot use it to launch the tests or only the currently-selected
	# RUBY interpreter will be tested.
	${RUBY} -S specrb -Ilib:test -w -a \
		-t '^(?!Rack::Handler|Rack::Adapter|Rack::Session::Memcache|Rack::Auth::OpenID)' \
		|| die "test failed for ${RUBY}"
}

all_ruby_install() {
	all_fakegem_install

	if [ "${SLOT}" != "0" ] ; then
		for f in "${ED}"/usr/bin/* ; do
			mv "${f}" "${f}-${SLOT}" || die "failed to mv ${f} to ${f}-${SLOT}."
		done
	fi
}
