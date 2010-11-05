# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-ConsoleTools/ezc-ConsoleTools-1.6.1-r1.ebuild,v 1.4 2010/11/05 04:39:46 jer Exp $

EAPI="2"

EZC_BASE_MIN="1.8"
inherit php-ezc

DESCRIPTION="This eZ component provides a set of classes to do different actions with the console."
SLOT="0"
KEYWORDS="amd64 hppa ~sparc x86"
IUSE=""

DEPEND="|| ( <dev-lang/php-5.3[spl] >=dev-lang/php-5.3 )"
RDEPEND="${DEPEND}"
