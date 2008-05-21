# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gammu/gammu-1.11.0.ebuild,v 1.6 2008/05/21 15:51:48 dev-zero Exp $

inherit eutils

DESCRIPTION="a fork of the gnokii project, a tool to handle your cellular phone"
HOMEPAGE="http://www.gammu.org"
SRC_URI="ftp://dl.cihar.com/gammu/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug bluetooth irda mysql postgres"

RDEPEND="bluetooth? ( net-wireless/bluez-libs )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )"
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )
	sys-devel/autoconf-wrapper
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-fixups.patch"
}

src_compile() {
	local myconf=""
	use debug && myconf="${myconf} --enable-debug"
	use bluetooth || myconf="${myconf} --disable-bluetooth"
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
