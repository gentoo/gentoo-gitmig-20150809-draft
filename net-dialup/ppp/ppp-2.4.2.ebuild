# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ppp/ppp-2.4.2.ebuild,v 1.1 2004/02/12 20:23:48 lanius Exp $

DESCRIPTION="Point-to-point protocol - patched for pppoe"
HOMEPAGE="http://www.samba.org/ppp"
SRC_URI="ftp://ftp.samba.org/pub/ppp/${P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa -amd64 ~ia64"
IUSE="ipv6 activefilter pam"

DEPEND="virtual/glibc
	activefilter? ( net-libs/libpcap )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}/mpls.patch
	epatch ${FILESDIR}/${PV}/killaddr-smarter.patch
	epatch ${FILESDIR}/${PV}/cflags.patch

	use activefilter && {
		einfo "Enabling active-filter"
		sed -i -e "s/^#FILTER=y/FILTER=y/" pppd/Makefile.linux
	}

	use pam && {
		einfo "Enabling PAM"
		sed -i -e "s/^#USE_PAM=y/USE_PAM=y/" pppd/Makefile.linux
	}

	use ipv6 && {
		einfo "Enabling IPv6"
		sed -i -e "s/#HAVE_INET6/HAVE_INET6/" pppd/Makefile.linux
	}

	einfo "Enabling CBCP"
	sed -i 's/^#CBCP=y/CBCP=y/' pppd/Makefile.linux

	einfo "Enabling radius"
	sed -i -e 's/SUBDIRS := rp-pppoe/SUBDIRS := rp-pppoe radius/' pppd/plugins/Makefile.linux
}

src_compile() {
	# compile radius better than their makefile does
	(cd pppd/plugins/radius/radiusclient; econf; emake) || die

	./configure --prefix=/usr || die
	emake COPTS="${CFLAGS}" || die
}

src_install() {
	for y in chat pppd pppdump pppstats
	do
		doman ${y}/${y}.8
		dosbin ${y}/${y}
	done
	chmod u+s-w ${D}/usr/sbin/pppd

	dodir /etc/ppp/peers
	insinto /etc/ppp
	insopts -m0600
	doins etc.ppp/pap-secrets etc.ppp/chap-secrets

	insopts -m0644
	doins etc.ppp/options
	doins ${FILESDIR}/${PV}/options-pptp
	doins ${FILESDIR}/${PV}/options-pppoe
	doins ${FILESDIR}/${PV}/chat-default

	insopts -m0755
	doins ${FILESDIR}/${PV}/ip-up
	doins ${FILESDIR}/${PV}/ip-down

	exeinto /etc/init.d/
	doexe ${FILESDIR}/${PV}/net.ppp0

	insinto /etc/conf.d
	insopts -m0600
	newins ${FILESDIR}/${PV}/confd.ppp0 net.ppp0

	dolib.so pppd/plugins/minconn.so
	dolib.so pppd/plugins/passprompt.so
	dolib.so pppd/plugins/rp-pppoe/rp-pppoe.so
	dodir /usr/lib/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)
	mv ${D}/usr/lib/*.so ${D}/usr/lib/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)

	insinto /etc/modules.d
	insopts -m0644
	newins ${FILESDIR}/${PV}/modules.ppp ppp

	dodoc PLUGINS README* SETUP Changes-2.3 FAQ
	dodoc ${FILESDIR}/${PV}/README.mpls
	dohtml ${FILESDIR}/${PV}/pppoe.html

	dosbin scripts/pon
	dosbin scripts/poff
	dosbin scripts/plog
	doman scripts/pon.1

	# Adding misc. specialized scripts to doc dir
	dodir /usr/share/doc/${PF}/scripts/chatchat
	insinto	/usr/share/doc/${PF}/scripts/chatchat
	doins scripts/chatchat/*
	insinto /usr/share/doc/${PF}/scripts
	doins scripts/*

	# install radius
	cd pppd/plugins/radius
	dolib.so radius.so
	dolib.so radattr.so
	dolib.so radrealms.so
	doman pppd-radius.8
	doman pppd-radattr.8
	cd radiusclient
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	if [ ! -e ${ROOT}dev/.devfsd ]
	then
		if [ ! -e ${ROOT}dev/ppp ]; then
			mknod ${ROOT}dev/ppp c 108 0
		fi
	fi
	if [ "$ROOT" = "/" ]
	then
		/sbin/update-modules
	fi
	ewarn "To enable kernel-pppoe read html/pppoe.html in the doc-directory."
	ewarn "Note: the library name has changed from pppoe.so to rp-pppoe.so."
	ewarn "Pon, poff and plog scripts have been supplied for experienced users."
	ewarn "New users or those requiring something more should have a look at"
	ewarn "the /etc/init.d/net.ppp0 script."
	ewarn "Users needing particular scripts (ssh,rsh,etc.)should check out the"
	ewarn "/usr/share/doc/ppp*/scripts directory."

	# lib name has changed
	sed -i -e "s:^pppoe.so:rp-pppoe.so:" ${ROOT}etc/ppp/options
}
