# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-nds/openldap/openldap-1.2.13-r6.ebuild,v 1.4 2002/07/17 02:53:35 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="LDAP suite of application and development tools"
SRC_URI="ftp://ftp.OpenLDAP.org/pub/OpenLDAP/openldap-release/${P}.tgz"
HOMEPAGE="http://www.OpenLDAP.org/"

SLOT="0"
LICENSE="OPENLDAP"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.1
        tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
        gdbm? ( >=sys-libs/gdbm-1.8.0 )"

src_compile() {
	local myconf
	use tcpd && myconf="${myconf} --enable-wrappers"
	use gdbm && myconf="${myconf} --enable-ldbm --with-ldbm-api=gdbm"
	use gdbm || myconf="${myconf} --disable-ldbm"

	./configure --host=${CHOST} --enable-passwd --enable-shell --enable-shared \
	--enable-static --prefix=/usr --sysconfdir=/etc --localstatedir=/var/lib \
	--mandir=/usr/share/man --libexecdir=/usr/lib/openldap ${myconf}
	assert "bad configure"

	make depend || die
	make || die "compile problem"
	cd tests ; make || die
}

src_install() {
	make prefix=${D}/usr sysconfdir=${D}/etc/openldap localstatedir=${D}/var/lib \
	mandir=${D}/usr/share/man libexecdir=${D}/usr/lib/openldap install
	assert "install problem"

	dodoc ANNOUNCEMENT CHANGES COPYRIGHT README LICENSE
	docinto rfc ; dodoc doc/rfc/*.txt
	docinto devel ; dodoc doc/devel/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/slapd.rc6 slapd
	newexe ${FILESDIR}/slurpd.rc6 slurpd

	cd ${D}/etc/openldap
	for i in *
	do
		cp $i $i.orig
		sed -e "s:${D}::" $i.orig > $i
		rm $i.orig
	done
}
