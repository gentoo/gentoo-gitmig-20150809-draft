# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.3_beta11.ebuild,v 1.2 2004/02/11 15:38:04 aliz Exp $

MY_P=${P/_beta/-beta}

DESCRIPTION="A simple utility to read the temperature of SMART capable hard drives"
HOMEPAGE="http://coredump.free.fr/linux/hddtemp.php"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc -sparc ~amd64"
DEPEND="virtual/glibc
	net-misc/wget"

SRC_URI="http://coredump.free.fr/linux/${MY_P}.tar.gz"
IUSE=""
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} ; cd ${S}

	ebegin "Trying to download the latest hddtemp.db file"
		wget -q --timeout=10 http://coredump.free.fr/linux/hddtemp.db
	eend $?
}

src_compile() {
	local myconf

	myconf="--with-db-path=/usr/share/hddtemp/hddtemp.db"
	# disabling nls breaks compiling
	#use nls || myconf="--disable-nls ${myconf}"
	econf $myconf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc README TODO Changelog COPYING

	insinto /usr/share/hddtemp
	if [ -f hddtemp.db ]; then
		doins hddtemp.db
	else
		doins ${FILESDIR}/hddtemp.db
	fi

	insinto /etc/conf.d ; donewins ${FILESDIR}/hddtemp-conf.d hddtemp
	exeinto /etc/init.d ; newexe ${FILESDIR}/hddtemp-init hddtemp
}
