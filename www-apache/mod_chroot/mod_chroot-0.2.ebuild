# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_chroot/mod_chroot-0.2.ebuild,v 1.2 2004/10/17 09:54:52 dholm Exp $


DESCRIPTION="chroot apache 1.x, the easy way"
HOMEPAGE="http://core.segfault.pl/~hobbit/mod_chroot/"
SRC_URI="http://core.segfault.pl/~hobbit/mod_chroot/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="=net-www/apache-1*"

src_unpack() {
	unpack ${A} || die; cd ${S} || die
}

src_compile() {
	apxs -c ${S}/mod_chroot.c -o ${S}/mod_chroot.so || die "Unable to compile mod_chroot.so ."
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe ${PN}.so || die "Cannot install mod_chroot.so"

	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/15_${PN}.conf
	dodoc CAVEATS ChangeLog EAPI INSTALL LICENSE README
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with this module."
	einfo "You should then edit your /etc/conf.d/apache file to suit."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
	${ROOT}/etc/apache/conf/apache.conf \
	extramodules/mod_chroot.so mod_chroot.c chroot_module \
	define=CHROOT addconf=conf/addon-modules/15_mod_chroot.conf
}
