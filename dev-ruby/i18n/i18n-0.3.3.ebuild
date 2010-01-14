# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/i18n/i18n-0.3.3.ebuild,v 1.1 2010/01/14 17:09:00 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_EXTRAINSTALL="vendor"

# doc regeneration seem to need Jeweler, which is not currently
# available
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.textile CHANGELOG.textile"

inherit ruby-fakegem

DESCRIPTION="Add Internationalization support to your Ruby application."
HOMEPAGE="http://rails-i18n.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="!<dev-ruby/activesupport-2.3.5-r2"
RDEPEND="${DEPEND}"

# This is an optional runtime dependency, for now consider it only a
# dependency for tests.
ruby_add_bdepend test dev-ruby/activerecord

src_prepare() {
	ruby-ng_src_prepare
	chmod 0755 ${WORKDIR/work/homedir} || die "Failed to fix permissions on home"
}

src_test() {
	chmod 0755 ${WORKDIR/work/homedir} || die "Failed to fix permissions on home"
	ruby-ng_src_test
}
