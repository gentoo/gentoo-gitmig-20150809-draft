# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gammu/gammu-1.10.0.ebuild,v 1.2 2007/03/26 21:29:40 mrness Exp $

DESCRIPTION="a fork of the gnokii project, a tool to handle your cellular phone"
HOMEPAGE="http://www.gammu.org"
SRC_URI="ftp://dl.cihar.com/gammu/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="debug bluetooth irda mysql postgres"

RDEPEND="bluetooth? ( net-wireless/bluez-libs )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )"
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )"

src_compile() {
	local myconf=""
	use debug && myconf="${myconf} --enable-debug"
	use bluetooth && myconf="${myconf} --with-bluedir=/usr/lib" \
		|| myconf="${myconf} --disable-bluetooth"
	use mysql || myconf="${myconf} --disable-mysql"
	use postgres || myconf="${myconf} --disable-pgsql"
	use irda || myconf="${myconf} --disable-irda"
	econf \
		--prefix=/usr \
		--enable-cb \
		--enable-7110incoming \
		${myconf} || die "configure failed"

	emake shared || die "make failed"
}

src_install () {
	make DESTDIR="${D}" installshared || die "install failed"
	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${P}"
}
