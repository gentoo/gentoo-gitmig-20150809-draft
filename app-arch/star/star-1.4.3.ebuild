# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/star/star-1.4.3.ebuild,v 1.8 2006/05/30 23:39:53 merlin Exp $

DESCRIPTION="An enhanced (world's fastest) tar, as well as enhanced mt/rmt"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/star.html"
#This URI for alpha versions
#SRC_URI="ftp://ftp.berlios.de/pub/${PN}/alpha/${PN}-${PV/_alpha/a}.tar.bz2"
#This URI for non-alpha versions
SRC_URI="ftp://ftp.berlios.de/pub/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${P/_alpha[0-9][0-9]}

src_unpack() {
	unpack ${A}
	cd ${S}/DEFAULTS
	sed -i \
		-e 's:/opt/schily:/usr:g' \
		-e 's:bin:root:g' \
		Defaults.linux
}

src_compile() {
	emake COPTX="${CFLAGS}" || die
}

src_install() {
	einstall INS_BASE=${D}/usr || die
	insinto /etc/default
	newins ${S}/rmt/rmt.dfl rmt

	# install mt as mt.star to not conflict with other packages
	mv ${D}/usr/bin/mt ${D}/usr/bin/mt.star

	dodoc BUILD Changelog AN-1.* README README.* PORTING TODO
	rm ${D}/usr/man/man1/match*
	dodir /usr/share/
	mv ${D}/usr/man/ ${D}/usr/share
	cd ${D}/usr/bin
	ln -s star ustar
	cd ${D}/usr/sbin
	mv rmt rmt.star
	dosym rmt.star /usr/sbin/rmt
	dosym rmt.1.gz /usr/share/man/man1/rmt.star.1.gz
}
