# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/prelude-manager/prelude-manager-0.8.10.ebuild,v 1.4 2004/03/19 00:06:47 weeve Exp $

inherit flag-o-matic

DESCRIPTION="Prelude-IDS Manager"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="ssl doc mysql postgres debug"

DEPEND="virtual/glibc
	!dev-libs/libprelude-cvs
	!app-admin/prelude-manager-cvs
	dev-libs/libprelude
	ssl? ( dev-libs/openssl )
	doc? ( dev-util/gtk-doc )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

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
