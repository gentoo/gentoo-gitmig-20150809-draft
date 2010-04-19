# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/eventmachine/eventmachine-0.12.10-r2.ebuild,v 1.1 2010/04/19 11:48:28 flameeyes Exp $

EAPI="2"
# jruby → has shims for Java handling but tests fail badly, remaining
# stuck; avoid that for now.
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="docs/ChangeLog README"

inherit ruby-fakegem

DESCRIPTION="EventMachine is a fast, simple event-processing library for Ruby programs."
HOMEPAGE="http://rubyeventmachine.com"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend 'dev-ruby/rake'

DEPEND="${DEPEND}
	dev-libs/openssl"
RDEPEND="${RDEPEND}
	dev-libs/openssl"

all_ruby_prepare() {
	# This test only works on BSD, and error handling fails on 1.8
	rm tests/test_process_watch.rb || die "rm failed"

	cat - > "${T}"/submake <<EOF
#!/bin/sh

myrealmake=${MAKE}
MAKE=\$myrealmake emake "\$@"

EOF
	chmod +x "${T}"/submake || die
}

each_ruby_compile() {
	MAKE="${T}"/submake ${RUBY} -S rake build || die "rake build failed"
}

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}/
	doins -r examples || die "Failed to install examples"
}
