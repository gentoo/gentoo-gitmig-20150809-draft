# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/libxml/libxml-0.5.4.ebuild,v 1.4 2008/07/18 18:11:01 coldwind Exp $

inherit gems

MY_P=${PN}-ruby-${PV}

DESCRIPTION="Ruby libxml with a user friendly API, akin to REXML, but feature complete and significantly faster."
HOMEPAGE="http://libxml.rubyforge.org"
SRC_URI="http://gems.rubyforge.org/gems/${MY_P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~hppa ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.6.6"
