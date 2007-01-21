# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-sjsxp-bin/sun-sjsxp-bin-1.0.ebuild,v 1.4 2007/01/21 18:21:45 flameeyes Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Sun Java Streaming XML Parser"

inherit java-wsdp

KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

DEPEND="dev-java/sun-jaxp-bin
	dev-java/jsr173"

REMOVE_JARS="jsr173_api"
