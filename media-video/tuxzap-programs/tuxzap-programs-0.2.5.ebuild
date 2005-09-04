# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tuxzap-programs/tuxzap-programs-0.2.5.ebuild,v 1.6 2005/09/04 11:15:44 zzam Exp $

IUSE="gtk"

MY_P=${PN/-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="mpegtools package for manipulation of various MPEG file formats"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4
	|| (
		>=sys-kernel/linux-headers-2.6.11-r2
		media-tv/linuxtv-dvb
	)
	>=media-libs/libdvb-0.2.1
	dev-libs/cdk
	gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {
	myconf='--with-dvb-path=/usr/lib'
	# not using X use var because gtk is needed too anyway
	use gtk || myconf=${myconf}' --without-x'
	econf ${myconf} || die

	# still assumes to be in the DVB dir
	sed -i \
		-e s%../../../libdvb%/usr/include/libdvb%g  \
		-e s%../../../include%/usr/include%g \
		${S}/src/Makefile

	emake || die 'compile failed'
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ${S}/README ${S}/AUTHORS ${S}/NEWS ${S}/ChangeLog
}
