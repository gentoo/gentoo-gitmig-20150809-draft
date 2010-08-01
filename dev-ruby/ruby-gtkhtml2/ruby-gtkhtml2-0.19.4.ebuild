# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkhtml2/ruby-gtkhtml2-0.19.4.ebuild,v 1.3 2010/08/01 09:54:00 hwoarang Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby GtkHtml2 bindings"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="${RDEPEND}
	=gnome-extra/gtkhtml-2*"
DEPEND="${DEPEND}
	=gnome-extra/gtkhtml-2*
	dev-util/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"

S="${WORKDIR}/ruby-gnome2-all-${PV}/gtkhtml2"
