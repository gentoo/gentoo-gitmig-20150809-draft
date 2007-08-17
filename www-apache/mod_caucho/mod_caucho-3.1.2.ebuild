# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_caucho/mod_caucho-3.1.2.ebuild,v 1.1 2007/08/17 08:21:44 nelchael Exp $

inherit eutils apache-module autotools

KEYWORDS="~amd64 ~ppc ~x86"

DESCRIPTION="mod_caucho connects Resin and Apache2."
HOMEPAGE="http://www.caucho.com/"
SRC_URI="http://www.caucho.com/download/resin-${PV}-src.zip"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/resin-${PV}"

# See apache-module.eclass for more information.
APACHE2_MOD_CONF="88_${PN}"
APACHE2_MOD_DEFINE="CAUCHO"

need_apache2

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-ssl.patch"
	epatch "${FILESDIR}/${P}-java.patch"
	eautoreconf
	chmod 755 ./configure
}

src_compile() {
	econf --with-apxs=${APXS2} || die "econf failed"

	emake -j1 -C "${S}/modules/c/src/apache2/" || die "emake failed"
}

src_install() {
	cd "${S}/modules/c/src/apache2"
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	insinto "${APACHE2_MODULES_CONFDIR}"
	doins "${FILESDIR}/${APACHE2_MOD_CONF}.conf" \
	|| die "internal ebuild error: '${FILESDIR}/${APACHE2_MOD_CONF}.conf' not found."
}
