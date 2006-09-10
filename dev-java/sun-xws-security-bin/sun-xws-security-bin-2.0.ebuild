# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-xws-security-bin/sun-xws-security-bin-2.0.ebuild,v 1.2 2006/09/10 15:37:14 nelchael Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="XML and Web Services Security"

inherit java-wsdp

KEYWORDS="~ppc ~x86"

DEPEND="${DEPEND}
	dev-java/sun-jaxrpc-bin"
