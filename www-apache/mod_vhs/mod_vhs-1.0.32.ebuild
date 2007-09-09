# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_vhs/mod_vhs-1.0.32.ebuild,v 1.1 2007/09/09 09:46:49 hollow Exp $

inherit eutils apache-module

DESCRIPTION="Mass Virtual Hosting System for Apache 2"
HOMEPAGE="http://www.oav.net/projects/mod_vhs/"
SRC_URI="http://www.oav.net/projects/mod_vhs/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="Apache-1.1"
SLOT="0"
IUSE="debug php suphp"

DEPEND="dev-libs/libhome
	php? ( dev-lang/php )
	suphp? ( www-apache/mod_suphp )"

myconf="-I/usr/include/home -lhome"
use php && myconf="${myconf} $(/usr/bin/php-config --includes) -DHAVE_MOD_PHP_SUPPORT"
use suphp && myconf="${myconf} -DHAVE_MOD_SUPHP_SUPPORT"
use debug myconf="${myconf} -DVH_DEBUG"

APXS2_ARGS="-a -c ${myconf} ${PN}.c"
APACHE2_MOD_CONF="99_${PN}"
APACHE2_MOD_DEFINE="VHS"

S="${WORKDIR}/${PN}"

need_apache2

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:chari:char:g' ${PN}.c
}
