# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-MvcFeedTiein/ezc-MvcFeedTiein-1.0.ebuild,v 1.2 2010/05/20 04:47:02 pva Exp $

EZC_BASE_MIN="1.8"
inherit php-ezc

DESCRIPTION="This eZ component provides a view handler that renders result data as an ATOM or RSS feed"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-MvcTools-1.1
	>=dev-php5/ezc-Feed-1.2.1"
