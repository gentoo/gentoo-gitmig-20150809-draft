# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-ImageConversion/ezc-ImageConversion-1.3.3.ebuild,v 1.1 2008/01/13 16:05:27 jokey Exp $

EZC_BASE_MIN="1.3.1"
inherit php-ezc

DESCRIPTION="This eZ component provides a set of classes to apply different filters on images."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-ImageAnalysis-1.1.2"
