# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-fastinfoset-bin/sun-fastinfoset-bin-1.0.1.ebuild,v 1.2 2006/09/10 15:29:50 nelchael Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Fast Infoset"

inherit java-wsdp

KEYWORDS="~ppc ~x86"

DEPEND="${DEPEND}
	dev-java/sun-sjsxp-bin"
