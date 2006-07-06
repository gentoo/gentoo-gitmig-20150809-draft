# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-wsdp-bin/sun-wsdp-bin-2.0.ebuild,v 1.1 2006/07/06 18:06:41 nelchael Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Java Web Services Developer Pack (Java WSDP)"

inherit java-wsdp

KEYWORDS="~x86"

DEPEND="dev-java/sun-fastinfoset-bin
	dev-java/sun-jaxb-bin
	dev-java/sun-jaxp-bin
	dev-java/sun-jaxr-bin
	dev-java/sun-jaxrpc-bin
	dev-java/sun-jaxws-bin
	dev-java/sun-jwsdp-shared-bin
	dev-java/sun-saaj-bin
	dev-java/sun-sjsxp-bin
	dev-java/sun-xmldsig-bin
	dev-java/sun-xws-security-bin"

src_unpack() {

	use doc && java-wsdp_src_unpack

}

src_install() {

	if use doc; then
		cd "${WORKDIR}/base"
		einfo "Installing documentation..."
		java-pkg_dohtml -r docs/*
	fi

}
