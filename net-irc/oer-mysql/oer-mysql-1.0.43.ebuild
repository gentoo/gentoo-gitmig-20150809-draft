# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/oer-mysql/oer-mysql-1.0.43.ebuild,v 1.4 2009/09/23 18:45:25 patrick Exp $

inherit fixheadtails versionator

MY_PN="oer+MySQL"

DESCRIPTION="Free to use GPL'd IRC bot"
HOMEPAGE="http://oer.equnet.org/"
SRC_URI="http://oer.equnet.org/testing/${MY_PN}-$(replace_version_separator 2 -).tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="debug static"

RDEPEND="virtual/mysql"
DEPEND="${RDEPEND}
	 >=sys-apps/sed-4"

S=${WORKDIR}/${MY_PN}-dist

src_unpack() {
	unpack ${A}
	ht_fix_file ${S}/configure
}

src_compile() {
	econf \
		--with-mysql=/usr \
		$(use_enable debug) \
		$(use_enable static) \
		|| die "econf failed"

	sed  -i -e "s:-O2:${CFLAGS}:" Makefile

	emake mycrypt || die "emake mycrypt failed"
	emake || die "emake failed"

	sed -i \
		-e 's:CRYPT=./mycrypt:CRYPT=/usr/lib/oer/mycrypt:' \
		-e 's:sample-configuration/oer+MySQL.conf:oer+MySQL.conf:' \
		-e 's:$CURRDIR/scripts/:/usr/share/oer/scripts/:' \
		${S}/pre_install.sh
}

src_install() {
	dobin oer+MySQL || die "dobin failed"

	insinto /usr/share/oer
	doins -r scripts || die "doins failed"
	exeinto /usr/share/oer
	doexe tools/*.pl pre_install.sh || die "doexe failed"
	exeinto /usr/lib/oer
	doexe mycrypt || die "doexe failed"
}
