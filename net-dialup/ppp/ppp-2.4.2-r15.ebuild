# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ppp/ppp-2.4.2-r15.ebuild,v 1.15 2006/04/24 17:42:17 kumba Exp $

inherit eutils gnuconfig flag-o-matic linux-info

DESCRIPTION="Point-to-point protocol (PPP)"
HOMEPAGE="http://www.samba.org/ppp"
SRC_URI="ftp://ftp.samba.org/pub/ppp/${P}.tar.gz
	mirror://gentoo/${P}-patches-20050729.tar.gz
	mppe-mppc? ( http://mppe-mppc.alphacron.de/ppp-2.4.2-mppe-mppc-1.1.patch.gz )
	dhcp? ( http://www.netservers.co.uk/gpl/ppp-dhcpc.tgz )"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="activefilter atm dhcp ipv6 mppe-mppc pam radius"

RDEPEND="virtual/libc
	activefilter? ( >=virtual/libpcap-0.9.3 )
	atm? ( net-dialup/linux-atm )
	pam? ( sys-libs/pam )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

pkg_setup() {
	if use mppe-mppc; then
		echo
		ewarn "The mppe-mppc flag overwrites the pppd native MPPE support with MPPE-MPPC"
		ewarn "patch developed by Jan Dubiec."
		ewarn "The resulted pppd will work only with patched kernels with version <= 2.6.14."
		einfo "You could obtain the kernel patch from MPPE-MPPC homepage:"
		einfo "   http://mppe-mppc.alphacron.de/"
		ewarn "CAUTION: MPPC is a U.S. patented algorithm!"
		ewarn "Ask yourself if you really need it and, if you do, consult your lawyer first."
		ebeep
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/patch/cbcp-dosfix.patch
	epatch ${WORKDIR}/patch/mpls.patch
	epatch ${WORKDIR}/patch/killaddr-smarter.patch
	epatch ${WORKDIR}/patch/cflags.patch
	epatch ${WORKDIR}/patch/control_c.patch
	epatch ${WORKDIR}/patch/activefilter-pcap-0.9.3.patch
	epatch ${WORKDIR}/patch/rp-pppoe-any-interface.patch

	use mppe-mppc && {
		einfo "Enabling mppe-mppc support"
		epatch ${WORKDIR}/ppp-2.4.2-mppe-mppc-1.1.patch
	}

	if use atm; then
		einfo "Enabling PPPoATM support"
		epatch ${WORKDIR}/patch/pppoatm-2.patch
		sed -i -e "s/^LIBS =/LIBS = -latm/" pppd/Makefile.linux || die "sed failed"
	fi

	use activefilter || {
		einfo "Disabling active-filter"
		sed -i -e "s/^FILTER=y/#FILTER=y/" pppd/Makefile.linux || die "sed failed"
	}

	use pam && {
		einfo "Enabling PAM"
		sed -i -e "s/^#USE_PAM=y/USE_PAM=y/" pppd/Makefile.linux || die "sed failed"
	}

	use ipv6 && {
		einfo "Enabling IPv6"
		sed -i -e "s/#HAVE_INET6/HAVE_INET6/" pppd/Makefile.linux || die "sed failed"
	}

	einfo "Enabling CBCP"
	sed -i 's/^#CBCP=y/CBCP=y/' pppd/Makefile.linux || die

	use radius && {
		einfo "Enabling RADIUS"
		sed -i -e 's/SUBDIRS := rp-pppoe/SUBDIRS := rp-pppoe radius/' pppd/plugins/Makefile.linux || die "sed failed"
		sed -i -e '/^CFLAGS/s:$: -fPIC:' pppd/plugins/radius/radiusclient/lib/Makefile.in || die "sed failed"
	}

	use dhcp && {
		# copy the ppp-dhcp plugin files
		einfo "Copying ppp-dhcp plugin files..."
		tar -xzf ${DISTDIR}/ppp-dhcpc.tgz -C ${S}/pppd/plugins/
		sed -i -e 's/SUBDIRS := rp-pppoe/SUBDIRS := rp-pppoe dhcp/' pppd/plugins/Makefile.linux || die "sed failed"
		sed -i -e "s/-O2/${CFLAGS} -fPIC/" ${S}/pppd/plugins/dhcp/Makefile.linux || die "sed failed"
		epatch ${WORKDIR}/patch/dhcp-sys_error_to_strerror.patch
	}

	#epatch ${FILESDIR}/${PV}/pcap.patch
	sed -i -e "s:net/bpf.h:pcap-bpf.h:" pppd/sys-linux.c pppd/demand.c pppd/plugins/rp-pppoe/if.c || die "sed failed"

	# Set correct libdir
	sed -i -e "s:/lib/pppd:/$(get_libdir)/pppd:" \
		${S}/pppd/{pathnames.h,pppd.8} || die "sed failed"
}

src_compile() {
	export WANT_AUTOCONF=2.1
	gnuconfig_update
	use radius && {
		# compile radius better than their makefile does
		append-ldflags -Wl,-z,now
		(cd pppd/plugins/radius/radiusclient && econf && emake -j1) || die "radiusclient build has failed"
	}
	./configure --prefix=/usr || die "configure failed"
	emake COPTS="${CFLAGS}" || die "build has failed"
}

src_install() {
	local y
	for y in chat pppd pppdump pppstats
	do
		doman ${y}/${y}.8
		dosbin ${y}/${y}
	done
	chmod u+s-w ${D}/usr/sbin/pppd

	dodir /etc/ppp/peers
	insinto /etc/ppp
	insopts -m0600
	newins etc.ppp/pap-secrets pap-secrets.example
	newins etc.ppp/chap-secrets chap-secrets.example

	insopts -m0644
	doins etc.ppp/options
	doins ${FILESDIR}/options-pptp
	doins ${FILESDIR}/options-pppoe
	doins ${FILESDIR}/chat-default

	insopts -m0755
	doins ${FILESDIR}/ip-up
	doins ${FILESDIR}/ip-down

	exeinto /etc/init.d/
	doexe ${FILESDIR}/net.ppp0

	if use pam; then
		insinto /etc/pam.d
		insopts -m0644
		newins pppd/ppp.pam ppp || die "not found ppp.pam"
	fi

	insinto /etc/conf.d
	insopts -m0600
	newins ${FILESDIR}/confd.ppp0 net.ppp0

	local PLUGINS_DIR=/usr/$(get_libdir)/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)
	#closing " for syntax coloring
	dodir ${PLUGINS_DIR}
	insinto ${PLUGINS_DIR}
	insopts -m0755
	doins pppd/plugins/minconn.so || die "minconn.so not build"
	doins pppd/plugins/passprompt.so || die "passprompt.so not build"
	doins pppd/plugins/rp-pppoe/rp-pppoe.so || die "rp-pppoe.so not build"
	if use atm; then
		doins pppd/plugins/pppoatm.so || die "pppoatm.so not build"
	fi
	if use dhcp; then
		doins pppd/plugins/dhcp/dhcpc.so || die "dhcpc.so not build"
	fi
	if use radius; then
		doins pppd/plugins/radius/radius.so || die "radius.so not build"
		doins pppd/plugins/radius/radattr.so || die "radattr.so not build"
		doins pppd/plugins/radius/radrealms.so || die "radrealms.so not build"

		doman pppd/plugins/radius/pppd-radius.8
		doman pppd/plugins/radius/pppd-radattr.8

		#Copy radiusclient configuration files
		#DO NOT INSTALL libradiusclient.so files!!! see #92878 for more info
		insinto /etc/radiusclient
		insopts -m0644
		doins pppd/plugins/radius/radiusclient/etc/{dictionary*,issue,port-id-map,radiusclient.conf,realms,servers}
	fi

	insinto /etc/modules.d
	insopts -m0644
	newins ${FILESDIR}/modules.ppp ppp
	if use mppe-mppc; then
		sed -i -e 's/ppp_mppe/ppp_mppe_mppc/' ${D}/etc/modules.d/ppp
	fi

	dodoc PLUGINS README* SETUP Changes-2.3 FAQ
	dodoc ${FILESDIR}/README.mpls
	dohtml ${FILESDIR}/pppoe.html

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
	if get_version ; then
		echo
		ewarn "If any of the following kernel configuration options is missing,"
		ewarn "you should reconfigure and rebuild your kernel before running pppd."
		CONFIG_CHECK="~PPP"
		use activefilter && CONFIG_CHECK="${CONFIG_CHECK} ~PPP_FILTER"
		CONFIG_CHECK="${CONFIG_CHECK} ~PPP_BSDCOMP ~PPP_DEFLATE"
		check_extra_config
		echo
	fi

	if ! [ -e ${ROOT}/dev/.devfsd ] || [ -e ${ROOT}/dev/.udev ];	then
		if [ ! -e ${ROOT}/dev/ppp ]; then
			mknod ${ROOT}/dev/ppp c 108 0
		fi
	fi
	if [ "$ROOT" = "/" ]; then
		/sbin/update-modules
	fi

	#create *-secrets files if not exists
	[ -f "${ROOT}/etc/ppp/pap-secrets" ] || \
		cp -pP "${ROOT}/etc/ppp/pap-secrets.example" "${ROOT}/etc/ppp/pap-secrets"
	[ -f "${ROOT}/etc/ppp/chap-secrets" ] || \
		cp -pP "${ROOT}/etc/ppp/chap-secrets.example" "${ROOT}/etc/ppp/chap-secrets"

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
