# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipsec-tools/ipsec-tools-0.7.2.ebuild,v 1.1 2009/04/23 13:37:02 dragonheart Exp $

inherit eutils flag-o-matic autotools linux-info

DESCRIPTION="A port of KAME's IPsec utilities to the Linux-2.6 IPsec implementation"
HOMEPAGE="http://ipsec-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="idea ipv6 pam rc5 readline selinux ldap kerberos nat hybrid iconv selinux"

# FIXME: what is the correct syntax for ~sparc ???
DEPEND="!sparc? ( >=sys-kernel/linux-headers-2.6 )
	readline? ( sys-libs/readline )
	pam? ( sys-libs/pam )
	ldap? ( net-nds/openldap )
	kerberos? ( virtual/krb5 )
	>=dev-libs/openssl-0.9.8
	iconv? ( virtual/libiconv )
	selinux? ( sys-libs/libselinux )"
#	radius? ( net-dialup/gnuradius )

RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-ipsec-tools )"

# {{{ kernel_check()
kernel_check() {
	get_version
	if kernel_is 2 6 ; then
		if test "${KV_PATCH}" -ge 19 ; then
		# Just for kernel >=2.6.19
			ebegin "Checking for suitable kernel configuration (Networking | Networking support | Networking options)"

			if use nat ; then
				if ! { linux_chkconfig_present NETFILTER_XT_MATCH_POLICY; } ; then
					ewarn "[NETFILTER_XT_MATCH_POLICY] IPsec policy match support is NOT enabled"
					eerror "${P} won't compile with use nat traversal (USE=nat) until you enable NETFILTER_XT_MATCH_POLICY in your kernel"
					die
				else
					einfo "....[NETFILTER_XT_MATCH_POLICY] IPsec policy match support is enabled :-)"
				fi
			fi
			# {{{ general stuff
			if ! { linux_chkconfig_present XFRM_USER; }; then
				ewarn "[XFRM_USER] Transformation user configuration interface is NOT enabled."
			else
				einfo "....[XFRM_USER] Transformation user configuration interface is enabled :-)"
			fi

			if ! { linux_chkconfig_present NET_KEY; }; then
				ewarn "[NET_KEY] PF_KEY sockets is NOT enabled."
			else
				einfo "....[NET_KEY] PF_KEY sockets is enabled :-)"
			fi
			# }}}
			# {{{ IPv4 stuff
			if ! { linux_chkconfig_present INET_IPCOMP; }; then
				ewarn "[INET_IPCOMP] IP: IPComp transformation is NOT enabled"
			else
				einfo "....[INET_IPCOMP] IP: IPComp transformation is enabled :-)"
			fi

			if ! { linux_chkconfig_present INET_AH; }; then
				ewarn "[INET_AH] AH Transformation is NOT enabled."
			else
				einfo "....[INET_AH] AH Transformation is enabled :-)"
			fi

			if ! { linux_chkconfig_present INET_ESP; }; then
				ewarn "[INET_ESP] ESP Transformation is NOT enabled."
			else
				einfo "....[INET_ESP] ESP Transformation is enabled :-)"
			fi

			if ! { linux_chkconfig_present INET_XFRM_MODE_TRANSPORT; }; then
				ewarn "[INET_XFRM_MODE_TRANSPORT] IP: IPsec transport mode is NOT enabled."
			else
				einfo "....[INET_XFRM_MODE_TRANSPORT] IP: IPsec transport mode is enabled :-)"
			fi

			if ! { linux_chkconfig_present INET_XFRM_MODE_TUNNEL; }; then
				ewarn "[INET_XFRM_MODE_TUNNEL] IP: IPsec tunnel mode is NOT enabled."
			else
				einfo "....[INET_XFRM_MODE_TUNNEL] IP: IPsec tunnel mode is enabled :-)"
			fi

			if ! { linux_chkconfig_present INET_XFRM_MODE_BEET; }; then
				ewarn "[INET_XFRM_MODE_BEET] IP: IPsec BEET mode is NOT enabled."
			else
				einfo "....[INET_XFRM_MODE_BEET] IP: IPsec BEET mode is enabled :-)"
			fi
			# }}}
			# {{{ IPv6 stuff
			if use ipv6 ; then
				if ! { linux_chkconfig_present INET6_IPCOMP; }; then
					ewarn "[INET6_IPCOMP] IPv6: IPComp transformation is NOT enabled"
				else
					einfo "....[INET6_IPCOMP] IPv6: IPComp transformation is enabled :-)"
				fi

				if ! { linux_chkconfig_present INET6_AH; }; then
					ewarn "[INET6_AH] IPv6: AH Transformation is NOT enabled."
				else
					einfo "....[INET6_AH] IPv6: AH Transformation is enabled :-)"
				fi

				if ! { linux_chkconfig_present INET6_ESP; }; then
					ewarn "[INET6_ESP] IPv6: ESP Transformation is NOT enabled."
				else
					einfo "....[INET6_ESP] IPv6: ESP Transformation is enabled :-)"
				fi

				if ! { linux_chkconfig_present INET6_XFRM_MODE_TRANSPORT; }; then
					ewarn "[INET6_XFRM_MODE_TRANSPORT] IPv6: IPsec transport mode is NOT enabled."
				else
					einfo "....[INET6_XFRM_MODE_TRANSPORT] IPv6: IPsec transport mode is enabled :-)"
				fi

				if ! { linux_chkconfig_present INET6_XFRM_MODE_TUNNEL; }; then
					ewarn "[INET6_XFRM_MODE_TUNNEL] IPv6: IPsec tunnel mode is NOT enabled."
				else
					einfo "....[INET6_XFRM_MODE_TUNNEL] IPv6: IPsec tunnel mode is enabled :-)"
				fi

				if ! { linux_chkconfig_present INET6_XFRM_MODE_BEET; }; then
					ewarn "[INET6_XFRM_MODE_BEET] IPv6: IPsec BEET mode is NOT enabled."
				else
					einfo "....[INET6_XFRM_MODE_BEET] IPv6: IPsec BEET mode is enabled :-)"
				fi
				if ! { linux_chkconfig_present CRYPTO_NULL; }; then
					ewarn "[CRYPTO_NULL] Crypto: NULL algorithm is NOT enabled"
				else
					einfo "....[CRYPTO_NULL] Cyrpto: Crypto NULL algorithm enabled :-)"
				fi
fi
			# }}}

			eend $?
		fi
	fi
}
# }}}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix for bug #76741
	sed -i 's:#include <sys/sysctl.h>::' src/racoon/pfkey.c src/setkey/setkey.c
	# fix for bug #124813
	sed -i 's:-Werror::g' "${S}"/configure.ac

	AT_M4DIR="${S}" eautoreconf
	epunt_cxx
}

src_compile() {
	# fix for bug #61025
	filter-flags -march=c3

	kernel_check

	myconf="--with-kernel-headers=${KV_DIR}/include \
			--enable-dependency-tracking \
			--enable-dpd \
			--enable-frag \
			--enable-stats \
			--enable-fastquit \
			--enable-stats \
			--enable-adminport \
			$(use_enable ipv6) \
			$(use_enable rc5) \
			$(use_enable idea) \
			$(use_with readline)
			$(use_enable kerberos gssapi) \
			$(use_with ldap libldap) \
			$(use_with pam libpam)"

#	we do not want broken-natt from the kernel
#	myconf="${myconf} $(use_enable broken-natt)"
	use nat && myconf="${myconf} --enable-natt --enable-natt-versions=yes"

	# we only need security-context when using selinux
	myconf="${myconf} $(use_enable selinux security-context)"

	# enable mode-cfg and xauth support
	if use pam; then
		myconf="${myconf} --enable-hybrid"
	else
		myconf="${myconf} $(use_enable hybrid)"
	fi

	# dev-libs/libiconv is hard masked
	#use iconv && myconf="${myconf} $(use_with iconv libiconv)"

	# the default (/usr/include/openssl/) is OK for Gentoo, leave it
	# myconf="${myconf} $(use_with ssl openssl )"

	# No way to get it compiling with freeradius or gnuradius
	# We would need libradius which only exists on FreeBSD

	# See bug #77369
	#myconf="${myconf} --enable-samode-unspec"

	econf ${myconf} || die
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	keepdir /var/lib/racoon
	newconfd "${FILESDIR}"/racoon.conf.d racoon
	newinitd "${FILESDIR}"/racoon.init.d racoon

	dodoc ChangeLog README NEWS
	dodoc src/racoon/samples/*
	dodoc src/racoon/doc/*

	docinto roadwarrior
	dodoc src/racoon/samples/roadwarrior/*

	docinto roadwarrior/client
	dodoc src/racoon/samples/roadwarrior/client/*
	docinto roadwarrior/server
	dodoc src/racoon/samples/roadwarrior/server/*

	docinto setkey
	dodoc src/setkey/sample.cf

	dodir /etc/racoon

	# RFC are only available from CVS for the moment, see einfo below
	#docinto "rfc"
	#dodoc ${S}/src/racoon/rfc/*
}

pkg_postinst() {
	if use nat; then
		elog
		elog " You have enabled the nat traversal functionnality."
		elog " Nat versions wich are enabled by default are 00,02,rfc"
		elog " you can find those drafts in the CVS repository:"
		elog "cvs -d anoncvs@anoncvs.netbsd.org:/cvsroot co ipsec-tools"
		elog
		elog "If you feel brave enough and you know what you are"
		elog "doing, you can consider emerging this ebuild"
		elog "with"
		elog "EXTRA_ECONF=\"--enable-natt-versions=08,07,06\""
		elog
	fi;

	if use ldap; then
		elog
		elog " You have enabled ldap support with {$PN}."
		elog " The man page does NOT contain any information on it yet."
		elog " Consider to use a more recent version or CVS"
		elog
	fi;

	elog
	elog "Please have a look in /usr/share/doc/${P} and visit"
	elog "http://www.netbsd.org/Documentation/network/ipsec/"
	elog "to find a lot of information on how to configure this great tool."
	elog
}

# vim: set foldmethod=marker nowrap :
