# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.3_beta8.ebuild,v 1.1 2003/08/31 18:31:56 mholzer Exp $

MY_P=${P/_beta/-beta}
HDDDB_VERSION=20030831
HDDDB_FILE=hddtemp-${HDDDB_VERSION}.db
HDDDB_DIR=/usr/share/${PN}

DESCRIPTION="A simple utility to read the temperature of SMART IDE hard drives"
HOMEPAGE="http://coredump.free.fr/linux/hddtemp.php"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
DEPEND="virtual/glibc"

SRC_URI="http://coredump.free.fr/linux/${MY_P}.tar.bz2
	mirror://gentoo/${HDDDB_FILE}.gz"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	gunzip <${DISTDIR}/${HDDDB_FILE}.gz >${WORKDIR}/${HDDDB_FILE}
	cd ${S}
	# patch Makefile
	export WANT_AUTOCONF_2_5="1"
	econf || die "configure failed"
	sed -i "s:/usr/share/misc/hddtemp.db:${HDDDB_DIR}/${HDDDB_FILE}:" configure
#	export WANT_AUTOCONF_2_5="1"
#	econf || die "configure failed"
	
}

src_compile() {
	make || die "make failed"
}

src_install() {
	dobin src/hddtemp
	insinto ${HDDDB_DIR}
	doins ${WORKDIR}/${HDDDB_FILE} 
	dodoc INSTALL README TODO ChangeLog COPYING
}
