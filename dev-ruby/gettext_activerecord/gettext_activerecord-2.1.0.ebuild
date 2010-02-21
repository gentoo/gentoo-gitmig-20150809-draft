# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gettext_activerecord/gettext_activerecord-2.1.0.ebuild,v 1.4 2010/02/21 17:11:09 armin76 Exp $

inherit gems

DESCRIPTION="An L10 library for ActiveRecord."
HOMEPAGE="http://www.yotabanana.com/hiki/ruby-gettext-rails.html"
LICENSE="Ruby"

KEYWORDS="amd64 ia64 ~ppc x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"

RDEPEND=">=dev-ruby/ruby-gettext-2.1.0
	>=dev-ruby/activerecord-2.3.2"
DEPEND="${RDEPEND}"
