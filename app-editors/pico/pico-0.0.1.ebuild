# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/pico/pico-0.0.1.ebuild,v 1.3 2002/08/06 16:29:59 gerk Exp $

HOMEPAGE="http://www.washington.edu/pine"
DESCRIPTION="Pico text editor"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

pkg_setup () {
	einfo "There is no real Pico here."
	einfo ""
	einfo 'Pico is part of net-mail/pine. Try "emerge app-editors/nano"'
	einfo "for a good Pico clone (it should be installed by default)."
	einfo ""
	einfo "If you really want to use the original Pico, you may want"
	einfo 'to try "emerge net-mail/pine" instead.'

	die "Pico is in net-mail/pine"
}

