# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkhtml2/ruby-gtkhtml2-0.16.0.ebuild,v 1.5 2008/03/30 15:29:25 armin76 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GtkHtml2 bindings"
KEYWORDS="~amd64 ia64 ~ppc sparc ~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND="=gnome-extra/gtkhtml-2*
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gtk2-${PV}
	dev-util/pkgconfig"

S="${WORKDIR}/ruby-gnome2-all-${PV}/gtkhtml2"
