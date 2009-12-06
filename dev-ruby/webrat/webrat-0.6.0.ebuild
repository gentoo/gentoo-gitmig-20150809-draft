# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/webrat/webrat-0.6.0.ebuild,v 1.1 2009/12/06 08:06:21 graaff Exp $

inherit gems

DESCRIPTION="Ruby acceptance testing for web applications"
HOMEPAGE="http://github.com/brynary/webrat/"
LICENSE="MIT"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"

RDEPEND=">=dev-ruby/nokogiri-1.2.0
	>=dev-ruby/rack-1.0"
DEPEND="${RDEPEND}"
