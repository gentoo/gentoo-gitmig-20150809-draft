# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gammu/gammu-0.94.0.ebuild,v 1.1 2004/03/13 08:03:15 st_lim Exp $

inherit eutils

DESCRIPTION="a fork of the gnokii project, a tool to handle your cellular phone"
SRC_URI="http://www.mwiacek.com/zips/gsm/gammu/older/${P}.tar.gz"
HOMEPAGE="http://www.mwiacek.com/gsm/gammu/gammu.html"

IUSE="nls bluetooth irda"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
S=$WORKDIR/${P}

RDEPEND="irda? ( sys-kernel/linux-headers )
	bluetooth? ( net-wireless/bluez-libs )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-LastCalendar.patch
}

src_compile() {
	local myconf
	use bluetooth && myconf="${myconf} --with-bluedir=/usr/lib"
	use irda || myconf="${myconf} --disable-irdaat --disable-irdaphonet"
	econf \
		`use_enable nls` \
		--prefix=/usr \
		--enable-cb \
		--enable-7110incoming \
		--enable-6210calendar \
		${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install () {
	make DESTDIR=${D} installlib || die "install failed"
	#doman docs/docs/english/gammu.1
	mv ${D}/usr/share/doc/${PN} ${D}/usr/share/doc/${P}
}
