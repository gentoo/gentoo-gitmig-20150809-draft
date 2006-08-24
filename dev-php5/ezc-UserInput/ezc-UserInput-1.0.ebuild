# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-UserInput/ezc-UserInput-1.0.ebuild,v 1.6 2006/08/24 02:12:38 weeve Exp $

inherit php-ezc

DESCRIPTION="This eZ component assists you to safely import user input variables into your application."
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND="${RDEPEND}
	dev-php5/pecl-filter"
