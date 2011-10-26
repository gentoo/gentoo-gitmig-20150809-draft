# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/selenium-webdriver/selenium-webdriver-2.9.1.ebuild,v 1.1 2011/10/26 18:01:15 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18"

# NOTE: this package contains precompiled code. It appears that all
# source code can be found at http://code.google.com/p/selenium/ but the
# repository is not organized in a way so that we can easily rebuild the
# suited shared object. We'll just try our luck with the precompiled
# objects for now.

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES README"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_QA_ALLOWED_LIBS="x_ignore_nofocus.so"

inherit ruby-fakegem

DESCRIPTION="This gem provides Ruby bindings for WebDriver."
HOMEPAGE="http://gemcutter.org/gems/selenium-webdriver"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/childprocess-0.2.1
	>=dev-ruby/ffi-1.0.7
	dev-ruby/json
	dev-ruby/rubyzip"

all_ruby_prepare() {
	# Match gemspec metadata up with our dependency adjustments.
	sed -i -e 's/json_pure/json/' ../metadata || die
}
