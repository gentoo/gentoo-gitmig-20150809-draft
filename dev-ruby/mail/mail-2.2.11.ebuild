# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mail/mail-2.2.11.ebuild,v 1.1 2010/12/04 19:49:05 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc README.rdoc TODO.rdoc"

inherit ruby-fakegem

GITHUB_USER="mikel"

DESCRIPTION="An email handling library"
HOMEPAGE="https://github.com/mikel/mail"
SRC_URI="https://github.com/${GITHUB_USER}/mail/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${GITHUB_USER}-${PN}-*"

ruby_add_rdepend "
	>=dev-ruby/activesupport-2.3.6
	>=dev-ruby/i18n-0.5.0
	>=dev-ruby/mime-types-1.16
	>=dev-ruby/treetop-1.4.8"

ruby_add_bdepend "test? ( dev-ruby/rspec:0 )"

all_ruby_prepare() {
	sed -i -e '/[Bb]undle/d' -e '6d' Rakefile || die "Unable to remove Bundler code."

	# Include active_support for cattr_reader
	# https://github.com/mikel/mail/issues/issue/159
	echo 'require "active_support/core_ext/class/attribute_accessors"' >> spec/environment.rb

	# Remove error email that isn't properly handled for now.
	# https://github.com/mikel/mail/issues/issue/160
	rm spec/fixtures/emails/error_emails/encoding_madness.eml || die
}
