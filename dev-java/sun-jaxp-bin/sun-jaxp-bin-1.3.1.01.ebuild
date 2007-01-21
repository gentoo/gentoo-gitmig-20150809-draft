# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jaxp-bin/sun-jaxp-bin-1.3.1.01.ebuild,v 1.3 2007/01/21 07:36:01 wltjr Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Java API for XML Processing"

inherit java-wsdp

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="${IUSE} dom4j"

DEPEND="${DEPEND}
	dev-java/sun-jwsdp-shared-bin
	dom4j? ( dev-java/dom4j )"
