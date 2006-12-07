# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/strongswan/strongswan-2.8.0.ebuild,v 1.2 2006/12/07 20:50:23 pylon Exp $

inherit eutils linux-info

DESCRIPTION="IPsec-based VPN Solution for Linux"
HOMEPAGE="http://www.strongswan.org/"
SRC_URI="http://download.strongswan.org/${P}.tar.bz2"

LICENSE="GPL-2 RSA-MD2 RSA-MD5 RSA-PKCS11"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="curl ldap smartcard"

COMMON_DEPEND="!net-misc/openswan
	dev-libs/gmp"
DEPEND="${COMMON_DEPEND}
	virtual/linux-sources
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )
	smartcard? ( dev-libs/opensc )"
RDEPEND="${COMMON_DEPEND}
	virtual/logger
	sys-apps/iproute2"

pkg_setup() {
	linux-info_pkg_setup

	if kernel_is 2 6; then
		einfo "This ebuild will set ${P} to use 2.6 native IPsec (KAME)."
		einfo "KLIPS will not be compiled/installed."
		MYMAKE="programs"

	elif kernel_is 2 4; then
		if ! [ -d /usr/src/linux/net/ipsec ]; then
			eerror "You need to have an IPsec enabled 2.4.x kernel."
			eerror "Ensure you have one running and make a symlink to it in /usr/src/linux"
			die
		fi

		einfo "Using patched-in IPsec code for kernel 2.4."
		einfo "Your kernel only supports KLIPS for kernel level IPsec."
		MYMAKE="confcheck programs"

	else
		eerror "Sorry, no support for your kernel version ${KV_FULL}."
		die "Install an IPsec enabled 2.4 or 2.6 kernel."
	fi
}

src_unpack() {
	unpack ${A}

	if use curl ; then
		ebegin "Curl support requested. Enabling curl support"
		sed -i -e 's:\(USE_LIBCURL?=\)false:\1true:g' Makefile.inc || die
		eend $?
	fi

	if use ldap ; then
		ebegin "LDAP support requested. Enabling LDAPv3 support"
		sed -i -e 's:\(USE_LDAP?=\)false:\1true:g' Makefile.inc || die
		eend $?
	fi

	if  use smartcard ; then
		ebegin "Smartcard support requested. Enabling opensc support"
		sed -i -e 's:\(USE_SMARTCARD?=\)false:\1true:g' Makefile.inc || die
		sed -i -e 's:\(PKCS11_DEFAULT_LIB=\\\"/usr/lib/pkcs11/opensc-pkcs11.so\\\"\):#\1:g' Makefile.inc || die
		sed -i -e 's:#\(PKCS11_DEFAULT_LIB=\\\"/usr/lib/opensc-pkcs11.so\\\"\):\1:g' Makefile.inc || die
		eend $?
	fi
}

src_compile() {
	make \
		DESTDIR="${D}" \
		USERCOMPILE="${CFLAGS}" \
		FINALCONFDIR=/etc/ipsec \
		INC_RCDEFAULT=/etc/init.d \
		INC_USRLOCAL=/usr \
		INC_MANDIR=share/man \
		FINALEXAMPLECONFDIR=/usr/share/doc/${P} \
		FINALDOCDIR=/usr/share/doc/${P} \
		${MYMAKE} || die "make failed"
}

src_install() {
	# make install wants this directory
	dodir /etc/init.d

	make \
		DESTDIR="${D}" \
		USERCOMPILE="${CFLAGS}" \
		FINALCONFDIR=/etc/ipsec \
		INC_RCDEFAULT=/etc/init.d \
		INC_USRLOCAL=/usr \
		INC_MANDIR=share/man \
		FINALEXAMPLECONFDIR=/usr/share/doc/${P} \
		FINALDOCDIR=/usr/share/doc/${P} \
		install || die "make install failed"

	dohtml doc/*html
	rm -f ${S}/doc/*.html
	dodoc CHANGES COPYING CREDITS INSTALL LICENSE README doc/*

	doinitd "${FILESDIR}"/ipsec

	fperms -R a-X /etc/ipsec /usr/share
	keepdir /var/run/pluto

	einfo "Configuration files are installed into /etc/ipsec/"
}

pkg_postinst() {
	if kernel_is 2 6; then
		CONFIG_CHECK="~NET_KEY ~INET_XFRM_MODE_TRANSPORT ~INET_XFRM_MODE_TUNNEL ~INET_AH ~INET_ESP ~INET_IPCOMP"
		WARNING_INET_AH="CONFIG_INET_AH:\tmissing IPsec AH support (needed if you want only authentication)"
		WARNING_INET_ESP="CONFIG_INET_ESP:\tmissing IPsec ESP support (needed if you want authentication and encryption)"
		WARNING_INET_IPCOMP="CONFIG_INET_IPCOMP:\tmissing IPsec Payload Compression (required for compress=yes)"
		check_extra_config
	fi
}
