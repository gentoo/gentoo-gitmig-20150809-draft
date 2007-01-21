# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jaxb-bin/sun-jaxb-bin-2.0-r2.ebuild,v 1.4 2007/01/21 18:15:50 flameeyes Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Java Architecture for XML Binding"

inherit java-wsdp

KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

DEPEND="${DEPEND}
	dev-java/sun-jaf
	dev-java/sun-jaxp-bin"

src_install() {

	java-wsdp_src_install
	dosym "/usr/share/${PN}/lib/jaxb-xjc.jar" "/usr/share/ant-core/lib/"
	dosym "/usr/share/sun-jaf/lib/activation.jar" "/usr/share/${PN}/lib/"

}
