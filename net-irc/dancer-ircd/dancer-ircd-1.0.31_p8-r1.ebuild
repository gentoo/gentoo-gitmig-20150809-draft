# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dancer-ircd/dancer-ircd-1.0.31_p8-r1.ebuild,v 1.1 2003/05/05 18:23:58 gmsoft Exp $

DESCRIPTION="A ircd with ipv6 support use by the freenode network"
HOMEPAGE="http://freenode.net/dancer_ircd.shtml"
SRC_URI="http://www.doc.ic.ac.uk/~aps100/dancer/dancer-ircd/stable/releases/dancer-ircd-${PV/_p/+maint}.tar.gz 
ipv6? ( http://freenode.net/dancer-maint5+IPv6.diff )"


DEPEND="doc? ( app-text/openjade
	dev-perl/SGMLSpm
	app-text/docbook-sgml-dtd
	app-text/docbook-sgml-utils )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~hppa"
IUSE="ipv6 doc"
#RDEPEND=""
S=${WORKDIR}/${PN}-${PV/_p/+maint}

[ -z "${SMALLNET}" ] && SMALLNET="y"

src_unpack() {
	unpack dancer-ircd-${PV/_p/+maint}.tar.gz
	use ipv6 && cd ${S} && patch -p1 < ${DISTDIR}/dancer-maint5+IPv6.diff

	
	cp ${S}/include/config.h ${S}/include/config.h.orig
	cat ${S}/include/config.h.orig | grep -v "#define KPATH" | grep -v "#define DLPATH" > ${S}/include/config.h
	echo "#define KPATH   \"etc/dancer-ircd/kline.conf\"" >> ${S}/include/config.h
	echo "#define DLPATH  \"etc/dancer-ircd/dline.conf\"" >> ${S}/include/config.h

	
	if [ "${SMALLNET}" = "y" ]
	then
		cp ${S}/include/config.h ${S}/include/config.h.tmp
		sed s/"#define NO_CHANOPS_ON_SPLIT"/"\/\/#define NO_CHANOPS_ON_SPLIT"/ ${S}/include/config.h.tmp  > ${S}/include/config.h
		rm ${S}/include/config.h.tmp
	fi
}

src_compile() {


	old_CFLAGS="${CFLAGS}" CFLAGS="${CFLAGS}" econf --enable-optimise --disable-errors --disable-debug-syms

	emake || die


}

src_install() {

	if [ "`use doc`" ]
	then
		echo doc
		docbook2html -u doc/sgml/dancer-oper-guide/dancer-oper-guide.sgml
		dohtml dancer-oper-guide.html
		
		docbook2html -u doc/sgml/dancer-user-guide/dancer-user-guide.sgml
		dohtml dancer-user-guide.html
	else
		echo nodoc
	fi
	dodoc doc/README doc/README.TSora doc/RELNOTES.hybrid-6 doc/Tao-of-IRC.940110 doc/README.umodes \
		doc/rfc1459.txt doc/example.conf doc/README.small_nets
		
	# Very outated man page	
	# doman doc/ircd.8 


	insinto /usr
	dobin src/dancer-ircd
	dobin tools/mkpasswd
	dobin tools/viconf

	dodir /etc/dancer-ircd/
	insinto /etc/dancer-ircd/
	doins doc/example.conf
	mv ${D}/etc/dancer-ircd/example.conf ${D}/etc/dancer-ircd/ircd.conf

	exeinto /etc/init.d/
	doexe ${FILESDIR}/dancer-ircd

	dodir /var/log/dancer-ircd/
	touch ${D}/var/log/dancer-ircd/.keep

}

pkg_postinst() {
	if [ "${SMALLNET}" = "y" ]
	then
		einfo If you intend to have more than one irc server
		einfo in your network, please reemerge with
		einfo "SMALLNET=\"n\" emerge dancer-ircd"
	fi

	if [ -z "`use doc`" ]
	then
		einfo If you need the dancer-oper-guide or the
		einfo dancer-user-guide, please reemerge with
		einfo "USE=\"doc\" emerge dancer-ircd"
	fi

}
