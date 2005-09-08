# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_XPath/PEAR-XML_XPath-1.2.1-r1.ebuild,v 1.1 2005/09/08 08:18:36 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="The PEAR::XML_XPath class provided an XPath/DOM XML manipulation, maneuvering and query interface"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

pkg_postinst () {
	einfo
	einfo "NOTE: This package requires the domxml extension."
	einfo "To enable domxml, add xml2 to your USE settings"
	einfo "and re-merge php."
	einfo
}
