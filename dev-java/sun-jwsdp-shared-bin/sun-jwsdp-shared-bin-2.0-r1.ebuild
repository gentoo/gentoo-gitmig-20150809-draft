# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jwsdp-shared-bin/sun-jwsdp-shared-bin-2.0-r1.ebuild,v 1.3 2007/01/21 07:28:18 wltjr Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Shared components for JWSDP"

inherit java-wsdp

KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-java/jta
	dev-java/xsdlib
	dev-java/relaxng-datatype
	dev-java/xml-commons-resolver
	dev-java/sun-javamail
	dev-java/sun-jaf"

REMOVE_JARS="xsdlib relaxngDatatype jta-spec1_0_1 resolver activation mail"
