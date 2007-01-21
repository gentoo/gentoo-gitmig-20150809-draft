# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jaxws-bin/sun-jaxws-bin-2.0-r1.ebuild,v 1.2 2007/01/21 07:59:42 wltjr Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Java API for XML Web Services"

inherit java-wsdp

KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="${DEPEND}
	dev-java/sun-saaj-bin
	dev-java/sun-jaxb-bin
	dev-java/jsr181
	dev-java/jsr250"

REMOVE_JARS="jsr181-api jsr250-api"
