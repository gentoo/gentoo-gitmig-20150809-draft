# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypserv/ypserv-2.5-r1.ebuild,v 1.3 2003/05/25 15:08:28 mholzer Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="NIS SERVER"
SRC_URI="mirror://kernel/linux/utils/net/NIS/${P}.tar.gz"
HOMEPAGE="http://www.linux-nis.org/nis/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND=">=sys-libs/gdbm-1.8.0"

src_compile() {
	econf --enable-yppasswd || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO

	insinto /etc ; doins etc/ypserv.conf etc/locale etc/netgroup etc/netmasks etc/timezone

	insinto /var/yp ; doins etc/securenets

	exeinto /etc/init.d
	newexe ${FILESDIR}/ypserv.rc6 ypserv
 	# Save the old config into the new package as CONFIG_PROTECT
        # doesn't work for this package.   
        if [ -f ${ROOT}/var/yp/Makefile ]; then
                mv ${D}/var/yp/Makefile ${D}/var/yp/Makefile.dist
                cp ${ROOT}/var/yp/Makefile ${D}/var/yp/Makefile
		einfo "As you have a previous /var/yp/Makefile, I have added"
		einfo "this file into the new package and installed the new"
		einfo "file as /var/yp/Makefile.dist"
        fi
}

pkg_postinst() {
	einfo "ypserv does not longer have support for tcp_wrappers. You need to"
	einfo "use /var/yp/securenets to allow/deny queries from other hosts."
}
