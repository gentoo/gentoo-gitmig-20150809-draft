# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_chroot/mod_chroot-0.4.ebuild,v 1.5 2007/09/21 20:57:33 hollow Exp $

inherit apache-module

KEYWORDS="ppc x86"

DESCRIPTION="mod_chroot allows you to run Apache in a chroot jail with no additional files."
HOMEPAGE="http://core.segfault.pl/~hobbit/mod_chroot/"
SRC_URI="http://core.segfault.pl/~hobbit/mod_chroot/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APXS2_S="${S}/src/apache20"
APACHE2_MOD_CONF="15_${PN}"
APACHE2_MOD_DEFINE="CHROOT"

DOCFILES="CAVEATS ChangeLog INSTALL README README.Apache20"

need_apache
