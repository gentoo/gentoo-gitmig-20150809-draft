# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-4.1.3.ebuild,v 1.6 2005/03/23 01:09:02 agriffis Exp $

inherit eutils

IUSE="ldap"

DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI="mirror://kernel/linux/daemons/${PN}/v4/${P}.tar.bz2"

DEPEND="ldap? ( >=net-nds/openldap-1.2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ppc64 ~sparc ~x86"

src_unpack() {
	unpack ${A}
#	cd ${S}
#	epatch ${FILESDIR}/ldap_config.patch || die "ldap patch died"

#	cd ${S}/include
#	epatch ${FILESDIR}/automount.diff || die "automount patch died"

	cd ${S}
	autoconf

	cd ${S}/daemon
	sed -i 's/LIBS \= \-ldl/LIBS \= \-ldl \-lnsl \$\{LIBLDAP\}/' Makefile
}

src_compile() {
	local myconf
	use ldap || myconf="--without-openldap"

	./configure \
	    --host=${HOST} \
	    --prefix=/usr \
	    ${myconf} || die
	sed -i -e '/^\(CFLAGS\|CXXFLAGS\|LDFLAGS\)[[:space:]]*=/d' Makefile.rules
	make || die "make failed"
}

src_install() {
	into /usr
	dosbin daemon/automount
	insinto /usr/lib/autofs
	insopts -m 755
	doins modules/*.so

	dodoc COPYING COPYRIGHT NEWS README* TODO
	cd man
	sed -i 's:\/etc\/:\/etc\/autofs\/:g' *.8 *.5 *.in
	doman auto.master.5 autofs.5 autofs.8 automount.8

	cd ../samples
	dodir /etc/autofs
	cp ${FILESDIR}/auto.master ${D}/etc/autofs
	cp ${FILESDIR}/auto.misc ${D}/etc/autofs

	exeinto /etc/init.d ; newexe ${FILESDIR}/autofs.rc8 autofs
	insinto /etc/conf.d ; newins ${FILESDIR}/autofs.confd autofs
}

pkg_postinst() {
	einfo "Note: If you plan on using autofs for automounting"
	einfo "remote NFS mounts without having the NFS daemon running"
	einfo "please add portmap to your default run-level."
	echo ""
	einfo "Also the normal autofs status has been renamed stats"
	einfo "as there is already a predefined Gentoo status"
}
