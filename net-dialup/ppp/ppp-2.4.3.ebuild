# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ppp/ppp-2.4.3.ebuild,v 1.2 2004/11/27 13:34:46 mrness Exp $

inherit eutils gnuconfig flag-o-matic

IUSE="gtk ipv6 activefilter pam atm mppe-mppc dhcp"

DESCRIPTION="Point-to-point protocol"
HOMEPAGE="http://www.samba.org/ppp"
SRC_URI="ftp://ftp.samba.org/pub/ppp/${P}.tar.gz
	mppe-mppc? ( http://www.polbox.com/h/hs001/ppp-2.4.3-mppe-mppc-1.1.patch.gz )
	dhcp? ( http://www.netservers.co.uk/gpl/ppp-dhcpc.tgz )"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"

RDEPEND="virtual/libc
	activefilter? ( >=net-libs/libpcap-0.8.3-r1 )
	atm? ( net-dialup/linux-atm )
	pam? ( sys-libs/pam )
	gtk? ( =x11-libs/gtk+-1* )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}/ppp_flags.patch || die "patch failed"
	epatch ${FILESDIR}/${PV}/mpls.patch || die "patch failed"
	epatch ${FILESDIR}/${PV}/killaddr-smarter.patch || die "patch failed"

	useq mppe-mppc && {
		einfo "Enabling mppe-mppc support"
		epatch ${DISTDIR}/ppp-2.4.3-mppe-mppc-1.1.patch.gz || die "patch failed"
	}

	useq atm && {
		einfo "Enabling PPPoATM support"
		sed -i "s/^#HAVE_LIBATM=yes/HAVE_LIBATM=yes/" ${S}/pppd/plugins/pppoatm/Makefile.linux
	}

	useq activefilter || {
		einfo "Disabling active filter"
		sed -i "s/^FILTER=y/#FILTER=y/" pppd/Makefile.linux
	}

	useq pam && {
		einfo "Enabling PAM"
		sed -i "s/^#USE_PAM=y/USE_PAM=y/" pppd/Makefile.linux
	}

	useq ipv6 && {
		einfo "Enabling IPv6"
		sed -i "s/#HAVE_INET6/HAVE_INET6/" pppd/Makefile.linux
	}

	einfo "Enabling CBCP"
	sed -i "s/^#CBCP=y/CBCP=y/" ${S}/pppd/Makefile.linux

	useq dhcp && {
		# copy the ppp-dhcp plugin files
		einfo "Copying ppp-dhcp plugin files..."
		tar -xzf ${DISTDIR}/ppp-dhcpc.tgz -C ${S}/pppd/plugins/
		sed -i 's/SUBDIRS := rp-pppoe/SUBDIRS := rp-pppoe dhcp/' ${S}/pppd/plugins/Makefile.linux
		sed -i "s/-O2/${CFLAGS} -fPIC/" ${S}/pppd/plugins/dhcp/Makefile.linux
	}
}

src_compile() {
	#export WANT_AUTOCONF=2.1
	#gnuconfig_update
	# compile radius better than their makefile does
	append-ldflags -Wl,-z,now
	econf || die "configuration failed"
	emake COPTS="${CFLAGS}" || die "compile failed"

	#build pppgetpass
	cd contrib/pppgetpass
	if useq gtk; then
		emake -f Makefile.linux || die "failed to build pppgetpass"
	else
		emake pppgetpass.vt || die "failed to build pppgetpass"
	fi
}

src_install() {
	local y
	for y in chat pppd pppdump pppstats
	do
		doman ${y}/${y}.8
		dosbin ${y}/${y}
	done
	chmod u+s-w ${D}/usr/sbin/pppd

	dosbin pppd/plugins/rp-pppoe/pppoe-discovery

	insinto /etc/ppp
	insopts -m0600
	newins etc.ppp/pap-secrets pap-secrets.example
	newins etc.ppp/chap-secrets chap-secrets.example

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

	if useq pam; then
		insinto /etc/pam.d
		insopts -m0644
		newins pppd/ppp.pam ppp || die "not found ppp.pam"
	fi

	insinto /etc/conf.d
	insopts -m0600
	newins ${FILESDIR}/${PV}/confd.ppp0 net.ppp0

	dolib.so pppd/plugins/minconn.so
	dolib.so pppd/plugins/passprompt.so
	dolib.so pppd/plugins/passwordfd.so
	dolib.so pppd/plugins/winbind.so
	dolib.so pppd/plugins/rp-pppoe/rp-pppoe.so
	dolib.so pppd/plugins/radius/radius.so
	dolib.so pppd/plugins/radius/radattr.so
	dolib.so pppd/plugins/radius/radrealms.so
	if useq atm; then
		dolib.so pppd/plugins/pppoatm/pppoatm.so || die "pppoatm.so not build"
	fi
	if useq dhcp; then
		dolib.so pppd/plugins/dhcp/dhcpc.so || die "dhcpc.so not build"
	fi

	dodir /usr/lib/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)
	mv ${D}/usr/lib/*.so ${D}/usr/lib/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)

	insinto /etc/modules.d
	insopts -m0644
	newins ${FILESDIR}/${PV}/modules.ppp ppp
	if useq mppe-mppc; then
		echo 'alias ppp-compress-18 ppp_mppe_mppc' >> ${D}/etc/modules.d/ppp
	fi

	dodoc PLUGINS README* SETUP Changes-2.3 FAQ
	dodoc ${FILESDIR}/${PV}/README.mpls
	dohtml ${FILESDIR}/${PV}/pppoe.html

	doman pppd/plugins/radius/pppd-radius.8
	doman pppd/plugins/radius/pppd-radattr.8

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

	if useq gtk; then
		dosbin contrib/pppgetpass/{pppgetpass.vt,pppgetpass.gtk}
		newsbin contrib/pppgetpass/pppgetpass.sh pppgetpass
	else
		newsbin contrib/pppgetpass/pppgetpass.vt pppgetpass
	fi
	doman contrib/pppgetpass/pppgetpass.8
}

pkg_postinst() {
	if [ ! -e ${ROOT}dev/.devfsd ] && [ ! -e ${ROOT}dev/.udev ]
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
