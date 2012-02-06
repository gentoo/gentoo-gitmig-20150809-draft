# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdkpixbuf2/ruby-gdkpixbuf2-0.90.8.ebuild,v 1.2 2012/02/06 17:27:35 ranger Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

inherit ruby-ng-gnome2

S=${WORKDIR}/ruby-gnome2-all-${PV}/gdk_pixbuf2

DESCRIPTION="Ruby GdkPixbuf2 bindings"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="${RDEPEND} x11-libs/gtk+:2"
DEPEND="${DEPEND}
	x11-libs/gtk+:2"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}"
ruby_add_bdepend "dev-ruby/pkg-config"
