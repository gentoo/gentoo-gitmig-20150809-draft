# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/prelude-manager/prelude-manager-0.9.9.1.ebuild,v 1.1 2007/09/05 16:50:28 jokey Exp $

inherit flag-o-matic

DESCRIPTION="Prelude-IDS Manager"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug xml dbx tcpwrapper"

RDEPEND="virtual/libc
	!dev-libs/libprelude-cvs
	!app-admin/prelude-manager-cvs
	>=dev-libs/libprelude-0.9.5
	dev-libs/openssl
	xml? ( dev-libs/libxml )
	dbx? ( dev-libs/libpreludedb )
	tcpwrapper? ( sys-apps/tcp-wrappers )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	local myconf

	use debug && append-flags -O -ggdb
	use !xml && myconf="${myconf} --disable-xmltest --enable-xmlmod"
	use dbx && myconf="${myconf} --enable-libpreludedb"
	use tcpwrapper && myconf="${myconf} --enable-libwrap"

	myconf="${myconf} --localstatedir=/var"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	newinitd "${FILESDIR}"/gentoo.init prelude-manager
	newconfd "${FILESDIR}"/gentoo.conf prelude-manager

	dodir /var/run/prelude-manager

	keepdir /var/spool/prelude-manager
	keepdir /var/run/prelude-manager
}
