# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-MvcTemplateTiein/ezc-MvcTemplateTiein-1.0.ebuild,v 1.1 2010/05/20 04:31:06 pva Exp $

EZC_BASE_MIN="1.8"
inherit php-ezc

DESCRIPTION="This eZ component provides a view handler that renders result data with the Template component"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-MvcTools-1.0
	>=dev-php5/ezc-Template-1.3.1"
