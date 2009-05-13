# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Derivative/Math-Derivative-0.01.ebuild,v 1.4 2009/05/13 16:23:49 ken69267 Exp $

EAPI=2

MODULE_AUTHOR=JARW
inherit perl-module

DESCRIPTION="1st and 2nd order differentiation of data"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# distribution without tests
SRC_TEST="no"
PATCHES=( "${FILESDIR}"/${PV}-pod-1.diff )
