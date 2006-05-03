# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ppp/ppp-2.4.3-r14.ebuild,v 1.2 2006/05/03 11:29:44 tove Exp $

inherit eutils flag-o-matic toolchain-funcs linux-info

DESCRIPTION="Point-to-Point Protocol (PPP)"
HOMEPAGE="http://www.samba.org/ppp"
SRC_URI="ftp://ftp.samba.org/pub/ppp/${P}.tar.gz
	mirror://gentoo/${P}-patches-20060409.tar.gz
	dhcp? ( http://www.netservers.co.uk/gpl/ppp-dhcpc.tgz )"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="activefilter atm dhcp eap-tls gtk ipv6 mppe-mppc pam radius"

DEPEND="activefilter? ( >=virtual/libpcap-0.9.3 )
	atm? ( net-dialup/linux-atm )
	pam? ( sys-libs/pam )
	gtk? ( =x11-libs/gtk+-1* )
	eap-tls? ( net-misc/curl >=dev-libs/openssl-0.9.7 )"

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

	if has_version "<${CATEGORY}/${PF}"; then
		local files=""
		[ -f "${ROOT}/etc/conf.d/net.ppp0" ] && files=( "${ROOT}/etc/conf.d/net.ppp0" )
		if [ -f "${ROOT}/etc/init.d/net.ppp0" ]; then
			local x y
			x=$(<"${ROOT}/etc/init.d/net.ppp0")
			y=$(<"${ROOT}/etc/init.d/net.lo")
			#It should be symlink to net.lo or at least have the same content
			if [ "$x" != "$y" ] ; then
				files=( ${files[@]} "${ROOT}/etc/init.d/net.ppp0" )
			fi
		fi

		if [[ -n "${files[@]}" ]]; then
			local f
			einfo "Gentoo is moving toward common configuration file for all network"
			einfo "interfaces. Thus starting from >=ppp-2.4.3-r10 the following files"
			einfo "are obsoleted and should be removed to avoid future confusion:"
			for f in ${files[@]} ; do
				eerror "    ${f//\/\///} - conflict with baselayout"
			done
			for f in chat-default options-pppoe options-pptp ; do
				f="${ROOT}/etc/ppp/${f}"
				if [ -f "${f}" ] ; then
					ewarn "    ${f//\/\///} - unused by this version"
					files=( ${files[@]} "${f}" )
				fi
			done
			echo
			einfo "If you use the old net.ppp0 script, you need to:"
			einfo "   - upgrade to >=sys-apps/baselayout-1.12.0_pre11"
			einfo "   - set ppp0 parameters in /etc/conf.d/net (see example file)"
			einfo "   - remove conflicting files"
			einfo "   - upgrade net-dialup/ppp"
			echo
			einfo "If you never used net.ppp0 script, just run the following commands:"
			einfo "    rm ${files[@]}"
			einfo "    emerge --resume"
			die "Conflicts with baselayout support detected"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}/patch/ppp_flags.patch"
	epatch "${WORKDIR}/patch/mpls.patch"
	epatch "${WORKDIR}/patch/killaddr-smarter.patch"
	epatch "${WORKDIR}/patch/upstream-fixes.patch"
	epatch "${WORKDIR}/patch/rp-pppoe-any-interface.patch"
	epatch "${WORKDIR}/patch/quiet-pppoatm-modprobe.patch"
	epatch "${WORKDIR}/patch/wait-children.patch"

	use eap-tls && {
		# see http://eaptls.spe.net/index.html for more info
		einfo "Enabling EAP-TLS support"
		epatch "${WORKDIR}/patch/eaptls-0.7-gentoo.patch"
		use mppe-mppc || epatch "${WORKDIR}/patch/eaptls-mppe-0.7.patch"
	}

	use mppe-mppc && {
		einfo "Enabling MPPE-MPPC support"
		epatch "${WORKDIR}/patch/mppe-mppc-1.1.patch"
		use eap-tls && epatch "${WORKDIR}/patch/eaptls-mppe-0.7-with-mppc.patch"
	}

	use atm && {
		einfo "Enabling PPPoATM support"
		sed -i "s/^#HAVE_LIBATM=yes/HAVE_LIBATM=yes/" pppd/plugins/pppoatm/Makefile.linux
	}

	use activefilter || {
		einfo "Disabling active filter"
		sed -i "s/^FILTER=y/#FILTER=y/" pppd/Makefile.linux
	}

	use pam && {
		einfo "Enabling PAM"
		sed -i "s/^#USE_PAM=y/USE_PAM=y/" pppd/Makefile.linux
	}

	use ipv6 && {
		einfo "Enabling IPv6"
		sed -i "s/#HAVE_INET6/HAVE_INET6/" pppd/Makefile.linux
	}

	einfo "Enabling CBCP"
	sed -i "s/^#CBCP=y/CBCP=y/" pppd/Makefile.linux

	use dhcp && {
		# copy the ppp-dhcp plugin files
		einfo "Copying ppp-dhcp plugin files..."
		tar -xzf "${DISTDIR}/ppp-dhcpc.tgz" -C pppd/plugins/ \
			&& sed -i -e 's/SUBDIRS := rp-pppoe/SUBDIRS := rp-pppoe dhcp/' pppd/plugins/Makefile.linux \
			&& sed -i -e "s/-O2/${CFLAGS} -fPIC/" \
					-e "s/gcc/\$(CC)/" pppd/plugins/dhcp/Makefile.linux \
			|| die "ppp-dhcp plugin addition failed"
		epatch "${WORKDIR}/patch/dhcp-sys_error_to_strerror.patch"
	}

	# Set correct libdir
	sed -i -e "s:/lib/pppd:/$(get_libdir)/pppd:" \
		pppd/{pathnames.h,pppd.8}

	find . -type f -name Makefile.linux \
		-exec sed -i -e '/^CC[[:space:]]*=/d' {} \;

	use radius && {
		#set the right paths in radiusclient.conf
		sed -i -e "s:/usr/local/etc:/etc:" \
			-e "s:/usr/local/sbin:/usr/sbin:" pppd/plugins/radius/etc/radiusclient.conf
		#set config dir to /etc/ppp/radius
		sed -i -e "s:/etc/radiusclient:/etc/ppp/radius:g" \
			pppd/plugins/radius/{*.8,*.c,*.h} \
			pppd/plugins/radius/etc/*
	}
}

src_compile() {
	export CC="$(tc-getCC)"
	export AR="$(tc-getAR)"
	append-ldflags $(bindnow-flags)
	econf || die "configuration failed"
	emake COPTS="${CFLAGS}" || die "compile failed"

	#build pppgetpass
	cd contrib/pppgetpass
	if use gtk; then
		emake -f Makefile.linux || die "failed to build pppgetpass"
	else
		emake pppgetpass.vt || die "failed to build pppgetpass"
	fi
}

pkg_preinst() {
	if use radius && [ -d "${ROOT}/etc/radiusclient" ] && has_version "<${CATEGORY}/${PN}-2.4.3-r5"; then
		ebegin "Copy /etc/radiusclient to /etc/ppp/radius"
		cp -pPR "${ROOT}/etc/radiusclient" "${ROOT}/etc/ppp/radius"
		eend $?
	fi
}

src_install() {
	local y
	for y in chat pppd pppdump pppstats
	do
		doman ${y}/${y}.8
		dosbin ${y}/${y}
	done
	chmod u+s-w "${D}/usr/sbin/pppd"

	dosbin pppd/plugins/rp-pppoe/pppoe-discovery

	dodir /etc/ppp/peers
	insinto /etc/ppp
	insopts -m0600
	newins etc.ppp/pap-secrets pap-secrets.example
	newins etc.ppp/chap-secrets chap-secrets.example

	insopts -m0644
	doins etc.ppp/options

	insopts -m0755
	newins "${FILESDIR}/ip-up.baselayout" ip-up
	newins "${FILESDIR}/ip-down.baselayout" ip-down

	if use pam; then
		insinto /etc/pam.d
		insopts -m0644
		newins pppd/ppp.pam ppp || die "not found ppp.pam"
	fi

	local PLUGINS_DIR=/usr/$(get_libdir)/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)
	#closing " for syntax coloring
	dodir "${PLUGINS_DIR}"
	insinto "${PLUGINS_DIR}"
	insopts -m0755
	doins pppd/plugins/minconn.so || die "minconn.so not build"
	doins pppd/plugins/passprompt.so || die "passprompt.so not build"
	doins pppd/plugins/passwordfd.so || die "passwordfd.so not build"
	doins pppd/plugins/winbind.so || die "winbind.so not build"
	doins pppd/plugins/rp-pppoe/rp-pppoe.so || die "rp-pppoe.so not build"
	if use atm; then
		doins pppd/plugins/pppoatm/pppoatm.so || die "pppoatm.so not build"
	fi
	if use dhcp; then
		doins pppd/plugins/dhcp/dhcpc.so || die "dhcpc.so not build"
	fi
	if use radius; then
		doins pppd/plugins/radius/radius.so || die "radius.so not build"
		doins pppd/plugins/radius/radattr.so || die "radattr.so not build"
		doins pppd/plugins/radius/radrealms.so || die "radrealms.so not build"

		#Copy radiusclient configuration files (#92878)
		insinto /etc/ppp/radius
		insopts -m0644
		doins pppd/plugins/radius/etc/{dictionary*,issue,port-id-map,radiusclient.conf,realms,servers}

		doman pppd/plugins/radius/pppd-radius.8
		doman pppd/plugins/radius/pppd-radattr.8
	fi

	insinto /etc/modules.d
	insopts -m0644
	newins "${FILESDIR}/modules.ppp" ppp
	if use mppe-mppc; then
		sed -i -e 's/ppp_mppe/ppp_mppe_mppc/' "${D}/etc/modules.d/ppp"
	fi

	dodoc PLUGINS README* SETUP Changes-2.3 FAQ
	dodoc "${FILESDIR}/README.mpls"

	dosbin scripts/pon
	dosbin scripts/poff
	dosbin scripts/plog
	doman scripts/pon.1

	# Adding misc. specialized scripts to doc dir
	dodir /usr/share/doc/${PF}/scripts/chatchat
	insinto /usr/share/doc/${PF}/scripts/chatchat
	doins scripts/chatchat/*
	insinto /usr/share/doc/${PF}/scripts
	doins scripts/*

	if use gtk; then
		dosbin contrib/pppgetpass/{pppgetpass.vt,pppgetpass.gtk}
		newsbin contrib/pppgetpass/pppgetpass.sh pppgetpass
	else
		newsbin contrib/pppgetpass/pppgetpass.vt pppgetpass
	fi
	doman contrib/pppgetpass/pppgetpass.8
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

	if [ ! -e "${ROOT}/dev/.devfsd" ] && [ ! -e "${ROOT}/dev/.udev" ] && [ ! -e "${ROOT}/dev/ppp" ]; then
		mknod "${ROOT}/dev/ppp" c 108 0
	fi
	if [ "$ROOT" = "/" ]; then
		/sbin/update-modules
	fi

	#create *-secrets files if not exists
	[ -f "${ROOT}/etc/ppp/pap-secrets" ] || \
		cp -pP "${ROOT}/etc/ppp/pap-secrets.example" "${ROOT}/etc/ppp/pap-secrets"
	[ -f "${ROOT}/etc/ppp/chap-secrets" ] || \
		cp -pP "${ROOT}/etc/ppp/chap-secrets.example" "${ROOT}/etc/ppp/chap-secrets"

	# lib name has changed
	sed -i -e "s:^pppoe.so:rp-pppoe.so:" "${ROOT}/etc/ppp/options"

	if use radius && has_version "<${CATEGORY}/${PN}-2.4.3-r5"; then
		echo
		ewarn "As of ${PN}-2.4.3-r5, the RADIUS configuration files have moved from"
		ewarn "   /etc/radiusclient to /etc/ppp/radius."
		einfo "For your convenience, radiusclient directory was copied to the new location."
	fi

	echo
	einfo "Pon, poff and plog scripts have been supplied for experienced users."
	einfo "Users needing particular scripts (ssh,rsh,etc.) should check out the"
	einfo "/usr/share/doc/ppp*/scripts directory."

	echo
	ewarn "The old /etc/init.d/net.ppp0 script has gone!"
	einfo "The new way of handling PPP connections of any kind (PPPoE, PPPoA, etc)"
	einfo "is through the baselayout's pppd net module."
	einfo "Make sure you have a supported version of baselayout by running:"
	einfo "   emerge -u '>=sys-apps/baselayout-1.12.0_pre11'"
}
