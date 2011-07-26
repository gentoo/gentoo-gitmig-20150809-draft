# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/prelude-manager/prelude-manager-1.0.0-r1.ebuild,v 1.3 2011/07/26 07:45:12 xarthisius Exp $

inherit flag-o-matic

DESCRIPTION="Prelude-IDS Manager"
HOMEPAGE="http://www.prelude-technologies.com"
SRC_URI="${HOMEPAGE}/download/releases/prelude-manager/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug xml dbx tcpwrapper"

RDEPEND="!dev-libs/libprelude-cvs
	!app-admin/prelude-manager-cvs
	>=dev-libs/libprelude-0.9.21.3
	net-libs/gnutls
	xml? ( dev-libs/libxml2 )
	dbx? ( >=dev-libs/libpreludedb-0.9.4 )
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
	myconf="${myconf} --docdir=/usr/share/doc/${PF}"

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

pkg_postinst() {
	elog "If you use it with mysql backend, take a look at mysql update files"
	elog "at ${ROOT}/usr/share/libpreludedb/classic"
}
