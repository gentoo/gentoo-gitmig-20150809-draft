# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-fs/autofs/autofs-3.1.7-r4.ebuild,v 1.5 2003/05/25 15:00:37 mholzer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Kernel based automounter"
HOMEPAGE="http://www.linux-consulting.com/Amd_AutoFS/autofs.html"
SRC_URI="mirror://kernel/linux/daemons/autofs/${P}.tar.bz2"

DEPEND="ldap? ( >=net-nds/openldap-1.2 )"
RDEPEND=">=net-nds/portmap-5b-r6
	>=net-nds/ypbind-1.11-r1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}  
	patch -p0 < ${FILESDIR}/nisyp.patch || die
	
	cd ${S}/include
	patch -p0 < ${FILESDIR}/automount.diff || die
}

src_compile() {
	local myconf
	use ldap || myconf="--without-openldap"
	export HAVE_LDAP=1 
	export LIBLDAP="$LIBLDAP -lldap -llber -lresolv"
	export LIBS="-lldap -llber -lresolv $LIBS"
	./configure --host=${HOST} --prefix=/usr ${myconf} || die
	emake || die
}

src_install() {
	into /usr
	dosbin daemon/automount
	insinto /usr/lib/autofs
	insopts -m 755
	doins modules/*.so

	dodoc COPYING COPYRIGHT NEWS README* TODO
	cd man
	doman auto.master.5 autofs.5 autofs.8 automount.8

	cd ../samples
	dodir /etc/autofs
	cp ${FILESDIR}/auto.master ${D}/etc/autofs
	cp ${FILESDIR}/auto.misc ${D}/etc/autofs

	exeinto /etc/init.d ; newexe ${FILESDIR}/autofs.rc7 autofs
	insinto /etc/conf.d ; newins ${FILESDIR}/autofs1.confd autofs
}

pkg_postinst() {

	einfo "Note: If you plan on using autofs for automounting"
	einfo "remote NFS mounts without having the NFS daemon running"
	einfo "please add portmap to your default run-level."
	echo ""
	einfo "Also the normal autofs status has been renamed stats"
	einfo "as there is already a predefined Gentoo status"
}	
