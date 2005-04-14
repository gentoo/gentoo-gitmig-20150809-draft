# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gammu/gammu-1.01.0.ebuild,v 1.1 2005/04/14 19:57:51 mrness Exp $

inherit eutils

MY_MAJOR_VER=${PV:0:3}

DESCRIPTION="a fork of the gnokii project, a tool to handle your cellular phone"
SRC_URI="http://www.mwiacek.com/zips/gsm/${PN}/stable/${MY_MAJOR_VER/./_}x/${P}.tar.gz"
HOMEPAGE="http://www.gammu.net/projects/gammu.php"

IUSE="bluetooth irda mysql nls ssl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND="mysql? ( dev-db/mysql )
	ssl? ( >=dev-libs/openssl-0.9.7d )
	bluetooth? ( net-wireless/bluez-libs )"

DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use bluetooth && myconf="${myconf} --with-bluedir=/usr/lib" \
		|| myconf="${myconf} --disable-bluefbus --disable-blueobex --disable-bluephonet --disable-blueat --disable-bluerfsearch --disable-fbusblue"
	use irda || myconf="${myconf} --disable-irdaat --disable-irdaphonet"
	sed -e 's:-lbluetooth -lsdp:-lbluetooth:g' \
		-i ${S}/cfg/autoconf/configure.in
	econf \
		`use_enable nls` \
		--prefix=/usr \
		--enable-cb \
		--enable-7110incoming \
		--enable-6210calendar \
		${myconf} || die "configure failed"

	sed -e 's:-lz  -pthread:-lz  -lpthread -lssl:g' \
		-i ${S}/cfg/Makefile.cfg
	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} installlib || die "install failed"
	doman docs/docs/english/gammu.1
	mv ${D}/usr/share/doc/${PN} ${D}/usr/share/doc/${P}
}
