# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipsec-tools/ipsec-tools-0.7.3-r1.ebuild,v 1.3 2011/04/06 01:01:46 flameeyes Exp $

inherit eutils flag-o-matic autotools linux-info

DESCRIPTION="A port of KAME's IPsec utilities to the Linux-2.6 IPsec implementation"
HOMEPAGE="http://ipsec-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="idea ipv6 pam rc5 readline selinux ldap kerberos nat hybrid iconv selinux"

DEPEND_COMMON="
	selinux? ( sys-libs/libselinux )
	readline? ( sys-libs/readline )
	pam? ( sys-libs/pam )
	ldap? ( net-nds/openldap )
	kerberos? ( virtual/krb5 )
	>=dev-libs/openssl-0.9.8
	iconv? ( virtual/libiconv )"
#	radius? ( net-dialup/gnuradius )

RDEPEND="${DEPEND_COMMON}
	selinux? ( sec-policy/selinux-ipsec-tools )"

DEPEND="${DEPEND_COMMON}
	>=sys-kernel/linux-headers-2.6.30"

pkg_setup() {
	get_version
	if kernel_is 2 6 ; then
		if test "${KV_PATCH}" -ge 19 ; then
		# Just for kernel >=2.6.19
			einfo "Checking for suitable kernel configuration (Networking | Networking support | Networking options)"

			if use nat; then
				CONFIG_CHECK="${CONFIG_CHECK} ~NETFILTER_XT_MATCH_POLICY"
				export WARNING_NETFILTER_XT_MATCH_POLICY="NAT support may fail weirdly unless you enable this option in your kernel"
			fi

			for i in XFRM_USER NET_KEY; do
				CONFIG_CHECK="${CONFIG_CHECK} ~${i}"
				eval "export WARNING_${i}='No tunnels will be available at all'"
			done

			for i in INET_IPCOMP INET_AH INET_ESP \
				INET_XFRM_MODE_TRANSPORT \
				INET_XFRM_MODE_TUNNEL \
				INET_XFRM_MODE_BEET ; do
				CONFIG_CHECK="${CONFIG_CHECK} ~${i}"
				eval "export WARNING_${i}='IPv4 tunnels will not be available'"
			done

			for i in INET6_IPCOMP INET6_AH INET6_ESP \
				INET6_XFRM_MODE_TRANSPORT \
				INET6_XFRM_MODE_TUNNEL \
				INET6_XFRM_MODE_BEET ; do
				CONFIG_CHECK="${CONFIG_CHECK} ~${i}"
				eval "export WARNING_${i}='IPv6 tunnels will not be available'"
			done

			CONFIG_CHECK="${CONFIG_CHECK} ~CRYPTO_NULL"
			export WARNING_CRYPTO_NULL="Unencrypted tunnels will not be available"
			export CONFIG_CHECK

			check_extra_config
		else
			eerror "You must have a kernel >=2.6.19 to run ipsec-tools."
			eerror "Building now, assuming that you will run on a different kernel"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix for bug #76741
	sed -i 's:#include <sys/sysctl.h>::' src/racoon/pfkey.c src/setkey/setkey.c
	# fix for bug #124813
	sed -i 's:-Werror::g' "${S}"/configure.ac
	# Fixing duplicate specification of vmbuf.h #300161
	epatch "${FILESDIR}"/${PN}-duplicate-header.patch
	# fix for building with gcc-4.6
	sed -i 's: -R: -Wl,-R:' "${S}"/configure.ac

	AT_M4DIR="${S}" eautoreconf
	epunt_cxx
}

src_compile() {
	# fix for bug #61025
	filter-flags -march=c3

	myconf="--with-kernel-headers=/usr/include \
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
