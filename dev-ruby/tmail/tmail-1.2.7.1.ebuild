# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tmail/tmail-1.2.7.1.ebuild,v 1.1 2010/05/23 19:27:04 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README CHANGES NOTES"

inherit ruby-fakegem

DESCRIPTION="An email handling library"
HOMEPAGE="http://rubyforge.org/projects/tmail/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~ppc-macos ~x64-solaris ~x86-solaris"
IUSE="debug"

# Tests seem to be broken with the new encoding handling from Ruby,
# need to be verified twice; code seems to work anyway.
RESTRICT=test

ruby_add_bdepend "
	dev-ruby/racc
	test? ( >=dev-ruby/mocha-0.9.5 )"

all_ruby_prepare() {
	# Provide file that is no longer distributed but still needed
	mkdir meta || die "Failed to mkdir meta."
	echo "tmail" > meta/unixname || die "Failed to create unixname file."
}

each_ruby_compile() {
	if [[ $(basename ${RUBY}) == "ruby18" ]]; then
		pushd ext/tmailscanner/tmail
		${RUBY} extconf.rb || die "extconf failed"
		emake || die "emake extension failed"
		popd
	fi

	emake -C lib/tmail $(use debug && echo DEBUG=true) parser.rb || die "emake failed"
}

each_ruby_install() {
	# We cannot use the recursive install because there are
	# racc source files and a makefile.
	find lib -name '*.rb' | while read file; do
		ruby_fakegem_newins $file $file
	done

	if [[ $(basename ${RUBY}) == "ruby18" ]]; then
		ruby_fakegem_newins ext/tmailscanner/tmail/tmailscanner.so lib/tmail/tmailscanner.so
	fi

	ruby_fakegem_genspec
}
