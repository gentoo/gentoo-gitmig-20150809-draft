# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Maik Schreiber <bZ@iq-computing.de>
# $Header: /var/cvsroot/gentoo-x86/app-editors/pico/pico-0.0.1.ebuild,v 1.1 2002/06/10 01:24:55 rphillips Exp $

HOMEPAGE="http://www.washington.edu/pine"
DESCRIPTION="Pico text editor"

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

