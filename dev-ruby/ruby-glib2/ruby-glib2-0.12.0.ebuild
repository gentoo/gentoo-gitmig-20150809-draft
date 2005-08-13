# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-glib2/ruby-glib2-0.12.0.ebuild,v 1.6 2005/08/13 23:17:30 hansmi Exp $

inherit ruby ruby-gnome2 eutils

DESCRIPTION="Ruby Glib2 bindings"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND=">=dev-libs/glib-2"

src_test() {
	if [ -z "$DISPLAY" ] || ! (/usr/X11R6/bin/xhost &>/dev/null) ; then
		ewarn
		ewarn "You are not authorised to connect to X server to run test."
		ewarn "Disabling run test."
		ewarn
		epause; ebeep; epause
	else
		cd tests
		ruby test-glib2.rb || die "test-glib2.rb failed"
	fi
}
