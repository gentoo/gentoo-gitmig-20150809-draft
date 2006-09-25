# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jwsdp-shared-bin/sun-jwsdp-shared-bin-2.0-r1.ebuild,v 1.2 2006/09/25 11:36:27 nelchael Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Shared components for JWSDP"

inherit java-wsdp

KEYWORDS="~ppc ~x86"

DEPEND="dev-java/jta
	dev-java/xsdlib
	dev-java/relaxng-datatype
	dev-java/xml-commons-resolver
	dev-java/sun-javamail
	dev-java/sun-jaf"

REMOVE_JARS="xsdlib relaxngDatatype jta-spec1_0_1 resolver activation mail"
