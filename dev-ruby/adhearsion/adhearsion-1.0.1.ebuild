# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/adhearsion/adhearsion-1.0.1.ebuild,v 1.1 2011/02/23 07:13:53 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG EVENTS README.markdown"
RUBY_FAKEGEM_EXTRAINSTALL="app_generators"

inherit ruby-fakegem

DESCRIPTION="'Adhesion you can hear' for integrating VoIP"
HOMEPAGE="http://adhearsion.com"
IUSE=""
SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

SRC_URI="https://github.com/adhearsion/adhearsion/tarball/${PV} -> ${P}.tgz"
S="${WORKDIR}/adhearsion-adhearsion-*"

ruby_add_bdepend "doc? ( dev-ruby/yard )"
ruby_add_bdepend "test? ( dev-ruby/rspec:2 dev-ruby/flexmock )"
ruby_add_rdepend ">=dev-ruby/rubigen-1.5.6
	>=dev-ruby/activesupport-2.1.0
	dev-ruby/i18n
	>=dev-ruby/log4r-1.0.5
	>=dev-ruby/bundler-1.0.10"

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r examples || die
}
