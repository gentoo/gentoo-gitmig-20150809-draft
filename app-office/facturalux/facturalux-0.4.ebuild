# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/facturalux/facturalux-0.4.ebuild,v 1.3 2004/04/07 18:44:37 vapier Exp $

inherit eutils

DESCRIPTION="General purpose ERP/CRM software"
HOMEPAGE="http://www.facturalux.org/"
SRC_URI="mirror://sourceforge/facturalux/${P}.tar.bz2
	mirror://sourceforge/facturalux/personalizacion-base-0.0.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/qt-3
	sys-libs/zlib"
RDEPEND="dev-db/postgresql"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${PN}-base-0.0-gentoo.patch
}

src_compile() {
	cd ${S}
	econf || die "configure failed"
	emake || die "parallel make failed"
	cd ${WORKDIR}/base-0.0
	econf || die "base-0.0 configure failed"
	emake || die "base-0.0 parallel make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	cd ${WORKDIR}/base-0.0
	make DESTDIR=${D} install || die "base-0.0 install failed"

	cd ${S}
	dodoc AUTHORS ChangeLog INSTALL LEEME NOTES README TODO
}

pkg_postinst() {
	einfo
	einfo "You must create a new database and a proper user:"
	einfo
	einfo "# su postgres"
	einfo "$ createdb -E UNICODE facturalux"
	einfo "$ createuser --pwprompt password"
	einfo
}
