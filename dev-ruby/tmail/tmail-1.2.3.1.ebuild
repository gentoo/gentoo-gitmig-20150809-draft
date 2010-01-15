# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tmail/tmail-1.2.3.1.ebuild,v 1.3 2010/01/15 17:59:13 grobian Exp $

EAPI=2
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README CHANGES NOTES"

inherit ruby-fakegem

DESCRIPTION="An email handling library"
HOMEPAGE="http://rubyforge.org/projects/tmail/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x64-solaris"
IUSE="debug"

# Tests seem to be broken with the new encoding handling from Ruby,
# need to be verified twice; code seems to work anyway.
RESTRICT=test

ruby_add_bdepend dev-ruby/racc
ruby_add_bdepend test '>=dev-ruby/mocha-0.9.5'

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

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc sample/* || die
}
