# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libgda/ruby-libgda-0.15.0.ebuild,v 1.4 2007/08/06 20:50:29 armin76 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby libgda (GNOME-DB) bindings"
KEYWORDS="alpha ia64 ~ppc ~sparc x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND="=gnome-extra/libgda-1*"
RDEPEND=">=dev-ruby/ruby-glib2-${PV}"
