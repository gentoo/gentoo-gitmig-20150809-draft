# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/prelude-manager/prelude-manager-0.9.0_rc8.ebuild,v 1.1 2005/08/19 22:51:29 vanquirius Exp $

inherit flag-o-matic versionator

MY_P="${PN}-$(replace_version_separator 3 '-')"
DESCRIPTION="Prelude-IDS Manager"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="doc debug xml dbx"

RDEPEND="virtual/libc
	!dev-libs/libprelude-cvs
	!app-admin/prelude-manager-cvs
	>=dev-libs/libprelude-0.9.0_rc5
	dev-libs/openssl
	doc? ( dev-util/gtk-doc )
	xml? ( dev-libs/libxml )
	dbx? ( dev-libs/libpreludedb )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf

	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --enable-gtk-doc=no"
	use debug && append-flags -O -ggdb
	use !xml && myconf="${myconf} --disable-xmltest"

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

	keepdir /var/lib/spool/prelude-manager
}
