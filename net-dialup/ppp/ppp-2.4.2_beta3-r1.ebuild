# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ppp/ppp-2.4.2_beta3-r1.ebuild,v 1.4 2003/12/27 14:37:21 lanius Exp $

MY_PV=${PV/_beta/b}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Point-to-point protocol - patched for pppoe"
HOMEPAGE="http://www.samba.org/ppp"
SRC_URI="ftp://ftp.samba.org/pub/ppp/${MY_P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa -amd64 ~ia64"
IUSE="ipv6 activefilter pam"

DEPEND="virtual/glibc
	activefilter? ( net-libs/libpcap )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${MY_PV}/mpls.patch
	epatch ${FILESDIR}/${MY_PV}/killaddr-smarter.patch
	epatch ${FILESDIR}/${MY_PV}/cflags.patch

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
}

src_compile() {
	cd ${S}

	# compile radiusclient better than their makefile does
	cd pppd/plugins/radius/radiusclient
	econf
	emake

	cd ${S}
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
	doins ${FILESDIR}/${MY_PV}/options-pptp
	doins ${FILESDIR}/${MY_PV}/options-pppoe
	doins ${FILESDIR}/${MY_PV}/chat-default

	insopts -m0755
	doins ${FILESDIR}/${MY_PV}/ip-up
	doins ${FILESDIR}/${MY_PV}/ip-down

	exeinto /etc/init.d/
	doexe ${FILESDIR}/${MY_PV}/net.ppp0

	insinto /etc/conf.d
	insopts -m0600
	newins ${FILESDIR}/${MY_PV}/confd.ppp0 net.ppp0

	dolib.so pppd/plugins/minconn.so
	dolib.so pppd/plugins/passprompt.so
	dolib.so pppd/plugins/rp-pppoe/rp-pppoe.so
	dodir /usr/lib/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)
	mv ${D}/usr/lib/*.so ${D}/usr/lib/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)

	insinto /etc/modules.d
	insopts -m0644
	newins ${FILESDIR}/${MY_PV}/modules.ppp ppp

	dodoc PLUGINS README* SETUP Changes-2.3 FAQ
	dodoc ${FILESDIR}/${MY_PV}/README.mpls
	dohtml ${FILESDIR}/${MY_PV}/pppoe.html

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
