# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.3_beta15-r1.ebuild,v 1.6 2007/03/24 18:43:40 nixnut Exp $

inherit eutils

MY_P=${P/_beta/-beta}

DESCRIPTION="A simple utility to read the temperature of SMART capable hard drives"
HOMEPAGE="http://www.guzu.net/linux/hddtemp.php"
SRC_URI="http://www.guzu.net/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="nls"

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-satacmds.patch
	epatch ${FILESDIR}/${P}-byteswap.patch
}

src_compile() {
	local myconf

	myconf="--with-db-path=/usr/share/hddtemp/hddtemp.db"
	# disabling nls breaks compiling
	use nls || myconf="--disable-nls ${myconf}"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README TODO ChangeLog

	insinto /usr/share/hddtemp
	doins ${FILESDIR}/hddtemp.db

	newconfd ${FILESDIR}/hddtemp-conf.d hddtemp
	newinitd ${FILESDIR}/hddtemp-init hddtemp
}

pkg_postinst() {
	einfo "In order to update your hddtemp database, run:"
	einfo "  emerge --config =${CATEGORY}/${PF}"
}

pkg_config() {
	cd ${ROOT}/usr/share/hddtemp

	einfo "Trying to download the latest hddtemp.db file"
	wget http://www.guzu.net/linux/hddtemp.db -O hddtemp.db
}
