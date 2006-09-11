# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jaxws-bin/sun-jaxws-bin-2.0-r1.ebuild,v 1.1 2006/09/11 11:51:42 nelchael Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Java API for XML Web Services"

inherit java-wsdp

KEYWORDS="~ppc ~x86"

DEPEND="${DEPEND}
	dev-java/sun-saaj-bin
	dev-java/sun-jaxb-bin
	dev-java/jsr181
	dev-java/jsr250"

REMOVE_JARS="jsr181-api jsr250-api"
