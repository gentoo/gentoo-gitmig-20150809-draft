# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or
# later
# $Header: /var/cvsroot/gentoo-x86/app-i18n/init-es/init-es-0.2-r1.ebuild,v 1.1 2003/06/19 16:13:05 bass Exp $


S=${WORKDIR}/${P}

LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc ~alpha ~sparc"

DESCRIPTION="Traductor de mensajes de inicio (init)"
SRC_URI="http://projects.frikis.org/gentoo/init-es/programa/${P}.tar.bz2"
HOMEPAGE="http://projects.frikis.org"

IUSE=""
SLOT="0"

RDEPEND="sys-apps/textutils
	sys-apps/sed"


src_install() {
	insinto /etc
	doins ${WORKDIR}/init-es-0.1/trad.es
	cd ${WORKDIR}/init-es-0.1/doc
	dodoc README ChangeLog
	exeinto /sbin
	doexe ${WORKDIR}/init-es-0.1/functions.sh
}

pkg_preinst() {
	if [ ! -f /sbin/functions.sh.ORIG ]
	then
		mv /sbin/functions.sh /sbin/functions.sh.ORIG
	fi
	if [ -f /sbin/functions.sh.ORIG ]
	then
		rm /sbin/functions.sh
	fi
}

pkg_postrm() {
	if [ ! -f /sbin/functions.sh ]
	then
		mv /sbin/functions.sh.ORIG /sbin/functions.sh
	fi
}
