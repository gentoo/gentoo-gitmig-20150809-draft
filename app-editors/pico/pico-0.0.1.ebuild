# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/pico/pico-0.0.1.ebuild,v 1.12 2004/06/27 22:18:15 vapier Exp $

DESCRIPTION="Pico text editor"
HOMEPAGE="http://www.washington.edu/pine"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc"

PROVIDE="virtual/editor"

pkg_setup () {
	einfo "There is no real Pico here."
	einfo ""
	einfo 'Pico is part of mail-client/pine. Try "emerge app-editors/nano"'
	einfo "for a good Pico clone (it should be installed by default)."
	einfo ""
	einfo "If you really want to use the original Pico, you may want"
	einfo 'to try "emerge mail-client/pine" instead.'

	die "Pico is in mail-client/pine"
}

