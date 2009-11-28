# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gettext/ruby-gettext-2.1.0.ebuild,v 1.1 2009/11/28 07:35:37 graaff Exp $

inherit gems

MY_P=${P/ruby-/}
DESCRIPTION="Ruby GetText Package is Native Language Support Library and Tools modeled after GNU gettext package"
HOMEPAGE="http://www.yotabanana.com/hiki/ruby-gettext.html"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""
SLOT="0"
LICENSE="Ruby"

USE_RUBY="ruby18"

RDEPEND=">=dev-ruby/locale-2.0.5
	sys-devel/gettext"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-package-${PV}"
