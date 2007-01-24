# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/prelude-manager/prelude-manager-0.8.10.ebuild,v 1.13 2007/01/24 14:49:40 genone Exp $

inherit flag-o-matic

DESCRIPTION="Prelude-IDS Manager"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 sparc x86"
IUSE="ssl doc mysql postgres debug"

RDEPEND="virtual/libc
	!dev-libs/libprelude-cvs
	!app-admin/prelude-manager-cvs
	<dev-libs/libprelude-0.9.0_rc1
	ssl? ( dev-libs/openssl )
	doc? ( dev-util/gtk-doc )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:serber:server:g' prelude-manager.conf*
}

src_compile() {
	local myconf

	use ssl && myconf="${myconf} --enable-openssl" || myconf="${myconf} --enable-openssl=no"
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --enable-gtk-doc=no"
	use mysql && myconf="${myconf} --enable-mysql" || myconf="${myconf} --enable-mysql=no"
	use postgres && myconf="${myconf} --enable-postgresql" || myconf="${myconf} --enable-postgresql=no"
	use debug && append-flags -O -ggdb

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/gentoo.init prelude-manager
	insinto /etc/conf.d
	insopts -m 644
	newins ${FILESDIR}/gentoo.conf prelude-manager
}

pkg_postinst() {
	elog "If you want to use unstable prelude, consider using unstable"
	elog "app-admin/prelude-manager to avoid undesired downgrades of"
	elog "dev-libs/libprelude."
}
