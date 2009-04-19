# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/locale_rails/locale_rails-2.0.1.ebuild,v 1.1 2009/04/19 07:49:48 graaff Exp $

inherit gems

DESCRIPTION="This library provides some Rails localized functions."
HOMEPAGE="http://www.yotabanana.com/hiki/ruby-gettext-rails.html"
LICENSE="Ruby"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"

RDEPEND=">=dev-ruby/locale-2.0.1"
DEPEND="${RDEPEND}"
