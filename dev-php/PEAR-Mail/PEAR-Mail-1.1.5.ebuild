# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Mail/PEAR-Mail-1.1.5.ebuild,v 1.1 2005/06/27 04:22:37 sebastian Exp $

inherit php-pear

DESCRIPTION="Class that provides multiple interfaces for sending emails"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-Net_SMTP-1.1.0"
