# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/pico/pico-0.0.1.ebuild,v 1.15 2007/01/24 02:50:32 genone Exp $

DESCRIPTION="Pico text editor"
HOMEPAGE="http://www.washington.edu/pine"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE=""

DEPEND=""

pkg_setup() {
	eerror "There is no real Pico here."
	eerror ""
	eerror 'Pico is part of mail-client/pine. Try "emerge app-editors/nano"'
	eerror "for a good Pico clone (it should be installed by default)."
	eerror ""
	eerror "If you really want to use the original Pico, you may want"
	eerror 'to try "emerge mail-client/pine" instead.'
	die "Pico is in mail-client/pine"
}
