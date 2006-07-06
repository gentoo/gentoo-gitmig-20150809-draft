# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-sjsxp-bin/sun-sjsxp-bin-1.0.ebuild,v 1.1 2006/07/06 18:03:17 nelchael Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Sun Java Streaming XML Parser"

inherit java-wsdp

KEYWORDS="~x86"

DEPEND="dev-java/sun-jaxp-bin
	dev-java/jsr173"

REMOVE_JARS="jsr173_api"
