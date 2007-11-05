# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups/cups-1.1.23-r8.ebuild,v 1.10 2007/11/05 22:00:57 mr_bones_ Exp $

# This ebuild is just kept here to not break the tree for mips stable

# UNMAINTAINED
# UNMAINTAINED
#  _  _ _  _ _  _ ____ _ _  _ ___ ____ _ _  _ ____ ___
#  |  | |\ | |\/| |__| | |\ |  |  |__| | |\ | |___ |  \
#  |__| | \| |  | |  | | | \|  |  |  | | | \| |___ |__/
# UNMAINTAINED
# UNMAINTAINED

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="http://www.cups.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="mips"
IUSE=""

S=${WORKDIR}/${MY_P}

pkg_setup() {
	eerror
	eerror "this version is unmaintained, old, and has many bugs - not only security bugs"
	eerror
	eerror "It does not work, please use a newer version"
	die "Please use newer version"
}
