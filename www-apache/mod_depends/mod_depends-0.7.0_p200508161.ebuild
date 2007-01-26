# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_depends/mod_depends-0.7.0_p200508161.ebuild,v 1.3 2007/01/26 17:55:37 trapni Exp $

inherit eutils apache-module

DESCRIPTION="An apache helper module for handling dependencies properly."
SRC_URI="http://mylair.de/~trapni/dist/mod_depends/${P}.tar.gz"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_depends/"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~x86 ~amd64"
IUSE=""

APACHE2_MOD_CONF="09_${PN}"
APACHE2_MOD_DEFINE="DEPENDS"

S="${WORKDIR}/${PN}"

need_apache2

src_compile() {
	cd ${S} || die

	econf --with-apxs="${APXS2}" || die "configure failed"

	emake || die "make failed"
}

src_install() {
	cd ${S} || die

	mv -v src/.libs/{lib,}mod_depends.so

	apache-module_src_install
}

# vim:ts=4
