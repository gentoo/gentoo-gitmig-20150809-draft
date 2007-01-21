# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-saaj-bin/sun-saaj-bin-1.3.ebuild,v 1.3 2007/01/21 07:54:48 wltjr Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="SOAP with Attachments API for Java"

inherit java-wsdp

KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="${DEPEND}
	dev-java/sun-fastinfoset-bin"
