# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_chroot/mod_chroot-0.5.ebuild,v 1.1 2006/06/05 17:12:21 hollow Exp $

inherit eutils apache-module

DESCRIPTION="mod_chroot allows you to run Apache in a chroot jail with no additional files"
HOMEPAGE="http://core.segfault.pl/~hobbit/mod_chroot/"
SRC_URI="http://core.segfault.pl/~hobbit/mod_chroot/dist/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""
SLOT="0"

APXS1_S="${S}/src/apache13"
APACHE1_MOD_CONF="15_${PN}"
APACHE1_MOD_DEFINE="CHROOT"

APXS2_S="${S}/src/apache20"
APACHE2_MOD_CONF="15_${PN}"
APACHE2_MOD_DEFINE="CHROOT"

DOCFILES="CAVEATS ChangeLog INSTALL README README.Apache20"

need_apache
