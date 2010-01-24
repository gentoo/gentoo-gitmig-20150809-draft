# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/prawn/prawn-0.7.1.ebuild,v 1.1 2010/01/24 15:44:14 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Fast, Nimble PDF Generation For Ruby"
HOMEPAGE="http://prawn.majesticseacreature.com/"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/prawn-core-${PV}
	>=dev-ruby/prawn-layout-${PV}
	>=dev-ruby/prawn-security-${PV}"
