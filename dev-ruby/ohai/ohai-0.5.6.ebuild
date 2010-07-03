# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ohai/ohai-0.5.6.ebuild,v 1.1 2010/07/03 12:10:38 hollow Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Ohai profiles your system and emits JSON"
HOMEPAGE="http://wiki.opscode.com/display/ohai"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/extlib
	<=dev-ruby/json-1.4.2
	dev-ruby/mixlib-cli
	dev-ruby/mixlib-config
	dev-ruby/mixlib-log
	dev-ruby/systemu"

all_ruby_prepare() {
	epatch "${FILESDIR}/ohai-lsb-release.patch"
}
