# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/osmlib-base/osmlib-base-0.1.4.ebuild,v 1.3 2010/06/07 10:23:18 angelos Exp $

inherit ruby gems

DESCRIPTION="A ruby library for OpenStreetMap."
HOMEPAGE="http://osmlib.rubyforge.org/"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
USE_RUBY="ruby18"

DEPEND=">=dev-ruby/libxml-0.5.4"
