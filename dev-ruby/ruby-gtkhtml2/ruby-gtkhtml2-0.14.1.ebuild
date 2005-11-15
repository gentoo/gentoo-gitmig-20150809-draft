# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkhtml2/ruby-gtkhtml2-0.14.1.ebuild,v 1.1 2005/11/15 10:47:55 citizen428 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GtkHtml2 bindings"
KEYWORDS="~sparc ~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND="=gnome-extra/libgtkhtml-2*
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"

S="${WORKDIR}/ruby-gnome2-all-${PV}/gtkhtml2"
