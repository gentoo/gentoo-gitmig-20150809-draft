# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-atk/ruby-atk-0.19.3.ebuild,v 1.1 2010/01/13 18:50:44 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Atk bindings"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-libs/atk"
RDEPEND="${DEPEND}"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}"
