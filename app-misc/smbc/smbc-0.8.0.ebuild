# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/smbc/smbc-0.8.0.ebuild,v 1.3 2004/11/30 21:19:11 swegener Exp $

inherit eutils

DESCRIPTION="Text mode SMB network commander"
HOMEPAGE="http://www.air.rzeszow.pl/smbc/smbc/en/"
SRC_URI="http://www.air.rzeszow.pl/${PN}/${PN}/${PV}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls debug"
DEPEND=">=net-fs/samba-3.0.1
	>=sys-devel/automake-1.8
	dev-libs/popt
	sys-libs/ncurses
	nls? ( sys-devel/gettext )"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e s:\/doc\/\":\/doc\/${PF}\/\": doc/Makefile.in \
		|| die "Unpack failed"
}

src_compile() {
	local myconf

	use nls \
	&& myconf="${myconf} `use_enable nls`" \
	|| myconf="${myconf} `use_enable nls`"
	use debug \
	&& myconf="${myconf} `use_with debug`"

	econf  ${myconf} || die "Configuration failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc ChangeLog
	prepalldocs
}
