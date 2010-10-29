# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/adhearsion/adhearsion-1.0.0.ebuild,v 1.1 2010/10/29 15:09:35 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST="" # specs are not distributed in the gem.
RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG EVENTS"
RUBY_FAKEGEM_EXTRAINSTALL="app_generators"

inherit ruby-fakegem

DESCRIPTION="'Adhesion you can hear' for integrating VoIP"
HOMEPAGE="http://adhearsion.com"
IUSE=""
SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

ruby_add_bdepend "doc? ( dev-ruby/yard )"
ruby_add_rdepend ">=dev-ruby/rubigen-1.0.6
	>=dev-ruby/activesupport-2.1.0
	>=dev-ruby/log4r-1.0.5"

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r examples || die
}
