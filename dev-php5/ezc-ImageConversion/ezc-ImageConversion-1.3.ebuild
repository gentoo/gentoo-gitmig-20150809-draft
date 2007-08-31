# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-ImageConversion/ezc-ImageConversion-1.3.ebuild,v 1.2 2007/08/31 14:34:02 jer Exp $

inherit php-ezc

DESCRIPTION="This eZ component provides a set of classes to apply different filters on images."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-ImageAnalysis-1.1.2"
