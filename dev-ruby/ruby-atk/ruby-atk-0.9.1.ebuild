# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-atk/ruby-atk-0.9.1.ebuild,v 1.6 2004/07/03 10:55:09 slarti Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Atk bindings"
KEYWORDS="alpha x86 ppc ~ia64 ~sparc ~amd64"
USE_RUBY="ruby18 ruby19"	# ruby16 is not supported
DEPEND="${DEPEND} dev-libs/atk"
RDEPEND="${RDEPEND} dev-libs/atk >=dev-ruby/ruby-glib2-${PV}"
