# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/locale_rails/locale_rails-2.0.5.ebuild,v 1.4 2010/04/18 14:00:28 nixnut Exp $

inherit gems

DESCRIPTION="This library provides some Rails localized functions."
HOMEPAGE="http://www.yotabanana.com/hiki/ruby-gettext-rails.html"
LICENSE="Ruby"

KEYWORDS="amd64 ppc x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"

RDEPEND=">=dev-ruby/locale-2.0.5"
DEPEND="${RDEPEND}"
