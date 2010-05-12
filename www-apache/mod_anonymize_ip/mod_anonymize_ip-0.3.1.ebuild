# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_anonymize_ip/mod_anonymize_ip-0.3.1.ebuild,v 1.1 2010/05/12 08:54:36 hollow Exp $

inherit apache-module

DESCRIPTION="mod_anonymize_ip is a simple module for anonymizing the client IP address."
HOMEPAGE="http://bb.xnull.de/projects/mod_anonymize_ip/"
SRC_URI="http://bb.xnull.de/projects/mod_anonymize_ip/dist/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="ANONYMIZE_IP"

need_apache2
