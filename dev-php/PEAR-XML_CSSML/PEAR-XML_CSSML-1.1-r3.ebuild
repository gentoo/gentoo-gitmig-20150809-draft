# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_CSSML/PEAR-XML_CSSML-1.1-r3.ebuild,v 1.2 2005/09/09 14:21:31 sebastian Exp $

inherit php-pear-r1

DESCRIPTION="A template system for generating cascading style sheets (CSS)"
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	sed 's/role="ext"/role="php"/g' -i ${WORKDIR}/package.xml
}
