# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/uptimed/uptimed-0.2.0-r1.ebuild,v 1.2 2002/07/25 19:18:35 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard informational utilities and process-handling tools"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/uptimed/${P}.tar.bz2"
HOMEPAGE="http://unixcode.org/uptimed"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 <${FILESDIR}/${P}.patch || die
}

src_compile() {
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/sbin
	dodir /var/spool/uptimed

	make DESTDIR=${D} install || die

	dodoc README NEWS TODO AUTHORS COPYING CREDITS
	exeinto /etc/init.d ; newexe ${FILESDIR}/uptimed uptimed
}

pkg_postinst() {
	echo -e "\e[32;01m To start uptimed, you must enable the /etc/init.d/uptimed rc file \033[0m"
	echo -e "\e[32;01m You may start uptimed now with: \033[0m"
	echo -e "\e[32;01m /etc/init.d/uptimed start \033[0m"
	echo -e "\e[32;01m To view your uptimes, use the command 'uprecords'.\033[0m"
}
