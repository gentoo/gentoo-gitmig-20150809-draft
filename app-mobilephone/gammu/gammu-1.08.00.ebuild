# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gammu/gammu-1.08.00.ebuild,v 1.6 2007/06/17 10:56:46 armin76 Exp $

inherit eutils

MY_MAJOR_VER=${PV:0:3}

DESCRIPTION="a fork of the gnokii project, a tool to handle your cellular phone"
HOMEPAGE="http://www.gammu.org"
SRC_URI="http://www.mwiacek.com/zips/gsm/${PN}/stable/${MY_MAJOR_VER/./_}x/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="debug bluetooth irda mysql"

RDEPEND="bluetooth? ( net-wireless/bluez-libs )
	mysql? ( virtual/mysql )"
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-backup-limits.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"
}

src_compile() {
	local myconf=""
	use debug && myconf="${myconf} --enable-debug"
	use bluetooth && myconf="${myconf} --with-bluedir=/usr/lib" \
		|| myconf="${myconf} --disable-bluetooth"
	use mysql || myconf="${myconf} --disable-mysql"
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
