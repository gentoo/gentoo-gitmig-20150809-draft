# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openswan/openswan-2.4.15-r2.ebuild,v 1.3 2011/06/06 06:18:52 robbat2 Exp $

EAPI="2"

inherit eutils linux-info toolchain-funcs

DESCRIPTION="Open Source implementation of IPsec for the Linux operating system (was SuperFreeS/WAN)."
HOMEPAGE="http://www.openswan.org/"
SRC_URI="http://www.openswan.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="curl ldap smartcard extra-algorithms weak-algorithms ms-bad-proposal"

COMMON_DEPEND="!net-misc/strongswan
	dev-libs/gmp
	dev-lang/perl
	smartcard? ( dev-libs/opensc )
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )"
DEPEND="${COMMON_DEPEND}
	virtual/linux-sources"
RDEPEND="${COMMON_DEPEND}
	virtual/logger
	sys-apps/iproute2"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is -ge 2 6; then
		einfo "This ebuild will set ${P} to use 2.6 native IPsec (KAME)."
		einfo "KLIPS will not be compiled/installed."
		MYMAKE="programs"

	elif kernel_is 2 4; then
		if ! [[ -d "${KERNEL_DIR}/net/ipsec" ]]; then
			eerror "You need to have an IPsec enabled 2.4.x kernel."
			eerror "Ensure you have one running and make a symlink to it in /usr/src/linux"
			die
		fi

		einfo "Using patched-in IPsec code for kernel 2.4"
		einfo "Your kernel only supports KLIPS for kernel level IPsec."
		MYMAKE="confcheck programs"

	else
		die "Unsupported kernel version"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-deprecated-ldap.patch
	use ms-bad-proposal && epatch "${FILESDIR}"/${PN}-${PV%.*}-allow-ms-bad-proposal.patch

	find . -type f -regex '.*[.]\([1-8]\|html\|xml\)' -exec sed -i \
	    -e 's:/usr/local:/usr:g' \
	    -e 's:/etc/ipsec[\][&][.]conf:/etc/ipsec/ipsec\\\&.conf:g' \
	    -e 's:/etc/ipsec[.]conf:/etc/ipsec/ipsec.conf:g' \
	    -e 's:/etc/ipsec[\][&][.]secrets:/etc/ipsec/ipsec\\\&.secrets:g' \
	    -e 's:/etc/ipsec[.]secrets:/etc/ipsec/ipsec.secrets:g' '{}' \; ||
	    die "failed to replace text in docs"
}

get_make_options() {
	echo KERNELSRC=\"${KERNEL_DIR}\" \
		FINALCONFDIR=/etc/ipsec \
		FINALCONFFILE=/etc/ipsec/ipsec.conf \
		FINALEXAMPLECONFDIR=/usr/share/doc/${PF} \
		INC_RCDEFAULT=/etc/init.d \
		INC_USRLOCAL=/usr \
		INC_MANDIR=share/man \
		FINALDOCDIR=/usr/share/doc/${PF} \
		DESTDIR=\"${D}\" \
		USERCOMPILE=\"${CFLAGS}\" \
		CC=\"$(tc-getCC)\"
	if use smartcard ; then
		echo USE_SMARTCARD=true
	fi
	if use extra-algorithms ; then
		echo USE_EXTRACRYPTO=true
	fi
	if use weak-algorithms ; then
		echo USE_WEAKSTUFF=true
	fi
	echo USE_OE=false # by default, turn off Opportunistic Encryption
	echo USE_LWRES=false # needs bind9 with lwres support
	local USETHREADS=false
	if use curl; then
		echo USE_LIBCURL=true
		USETHREADS=true
	fi
	if use ldap; then
		echo USE_LDAP=true
		USETHREADS=true
	fi
	echo HAVE_THREADS=${USETHREADS}
}

src_compile() {
	eval set -- $(get_make_options)
	emake "$@" \
		${MYMAKE} || die "emake failed"
}

src_install() {
	eval set -- $(get_make_options)
	emake "$@" \
		install || die "emake install failed"

	dodoc docs/{KNOWN_BUGS,RELEASE-NOTES*,debugging*}
	dodoc doc/*.html
	docinto quickstarts
	dodoc doc/quickstarts/*

	dosym /etc/ipsec/ipsec.d /etc/ipsec.d

	doinitd "${FILESDIR}"/ipsec || die "failed to install init script"

	dodir /var/run/pluto || die "failed to create /var/run/pluto"
}

pkg_postinst() {
	if kernel_is -ge 2 6; then
		CONFIG_CHECK="~NET_KEY ~INET_XFRM_MODE_TRANSPORT ~INET_XFRM_MODE_TUNNEL ~INET_AH ~INET_ESP ~INET_IPCOMP"
		WARNING_INET_AH="CONFIG_INET_AH:\tmissing IPsec AH support (needed if you want only authentication)"
		WARNING_INET_ESP="CONFIG_INET_ESP:\tmissing IPsec ESP support (needed if you want authentication and encryption)"
		WARNING_INET_IPCOMP="CONFIG_INET_IPCOMP:\tmissing IPsec Payload Compression (required for compress=yes)"
		check_extra_config
	fi
}
