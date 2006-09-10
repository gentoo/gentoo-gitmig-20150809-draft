# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jaxb-bin/sun-jaxb-bin-2.0-r1.ebuild,v 1.2 2006/09/10 15:28:40 nelchael Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Java Architecture for XML Binding"

inherit java-wsdp

KEYWORDS="~ppc ~x86"

DEPEND="${DEPEND}
	dev-java/sun-jaxp-bin"

src_install() {

	java-wsdp_src_install
	dosym "/usr/share/${PN}/lib/jaxb-xjc.jar" "/usr/share/ant-core/lib/"

}
