# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdkpixbuf2/ruby-gdkpixbuf2-1.1.3.ebuild,v 1.3 2012/08/17 13:03:28 johu Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_NAME="gdk_pixbuf2"

inherit ruby-ng-gnome2

S=${WORKDIR}/ruby-gnome2-all-${PV}/gdk_pixbuf2

DESCRIPTION="Ruby GdkPixbuf2 bindings"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}"
