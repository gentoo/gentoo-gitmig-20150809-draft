# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jaxb-bin/sun-jaxb-bin-2.0.ebuild,v 1.1 2006/07/06 17:54:18 nelchael Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Java Architecture for XML Binding"

inherit java-wsdp

KEYWORDS="~x86"

DEPEND="${DEPEND}
	dev-java/sun-jaxp-bin"
