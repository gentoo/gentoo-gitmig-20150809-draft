# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-fastinfoset-bin/sun-fastinfoset-bin-1.0.1.ebuild,v 1.3 2007/01/21 07:48:53 wltjr Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Fast Infoset"

inherit java-wsdp

KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="${DEPEND}
	dev-java/sun-sjsxp-bin"
