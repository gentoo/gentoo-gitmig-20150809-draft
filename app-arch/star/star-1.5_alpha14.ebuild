# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/star/star-1.5_alpha14.ebuild,v 1.3 2003/12/26 11:13:22 plasmaroo Exp $

S=${WORKDIR}/${P/_alpha[0-9][0-9]}

DESCRIPTION="An enhanced (world's fastest) tar, as well as enhanced mt/rmt"

#This URI for alpha versions
SRC_URI="ftp://ftp.berlios.de/pub/${PN}/alpha/${PN}-${PV/_alpha/a}.tar.bz2"
#This URI for non-alpha versions
#SRC_URI="ftp://ftp.berlios.de/pub/${PN}/${P}.tar.bz2"

HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/star.html"
KEYWORDS="x86 amd64 ~ppc sparc hppa alpha ia64"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/DEFAULTS
	sed -e 's:/opt/schily:/usr:g' -e 's:bin:root:g' -i Defaults.linux
	sed -e 's:/usr/src/linux/include:/usr/include:' -i Defaults.linux

	if [ "${ARCH}" = "amd64" ]
	then
		cd ${S}/RULES
		cp i386-linux-cc.rul x86_64-linux-cc.rul
		cp i386-linux-gcc.rul x86_64-linux-gcc.rul
	fi

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

	dodoc BUILD COPYING Changelog AN-1.* README README.* PORTING TODO
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
