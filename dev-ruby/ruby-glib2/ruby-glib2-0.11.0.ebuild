# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-glib2/ruby-glib2-0.11.0.ebuild,v 1.3 2005/04/01 05:13:01 agriffis Exp $

inherit ruby ruby-gnome2 eutils

DESCRIPTION="Ruby Glib2 bindings"
KEYWORDS="~alpha ~x86 ~ppc ~ia64 ~sparc ~amd64"
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
