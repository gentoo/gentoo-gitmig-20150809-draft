# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openswan/openswan-2.6.19.ebuild,v 1.2 2009/01/11 11:01:51 mrness Exp $

EAPI=1

inherit eutils linux-info

DESCRIPTION="Open Source implementation of IPsec for the Linux operating system (was SuperFreeS/WAN)."
HOMEPAGE="http://www.openswan.org/"
SRC_URI="http://www.openswan.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="curl ldap smartcard extra-algorithms weak-algorithms nocrypto-algorithms"

COMMON_DEPEND="!net-misc/strongswan
	dev-libs/gmp
	dev-lang/perl
	smartcard? ( dev-libs/opensc )
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )"
DEPEND="${COMMON_DEPEND}
	virtual/linux-sources
	app-text/xmlto
	app-text/docbook-xml-dtd:4.1.2" # see bug 237132
RDEPEND="${COMMON_DEPEND}
	virtual/logger
	sys-apps/iproute2"

pkg_setup() {
	if use nocrypto-algorithms && ! use weak-algorithms; then
		ewarn "Enabling nocrypto-algorithms USE flag has no effect when"
		ewarn "weak-algorithms USE flag is disabled"
	fi

	linux-info_pkg_setup

	if kernel_is 2 6; then
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

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-qa-fixes.patch

	find . -regex '.*[.][1-8]' -exec sed -i \
	    -e s:/usr/local:/usr:g '{}' \; ||
	    die "failed to replace text in xml docs"
}

get_make_options() {
	echo KERNELSRC=\"${KERNEL_DIR}\" \
		FINALEXAMPLECONFDIR=/usr/share/doc/${PF} \
		INC_RCDEFAULT=/etc/init.d \
		INC_USRLOCAL=/usr \
		INC_MANDIR=share/man \
		FINALDOCDIR=/usr/share/doc/${PF}/html \
		DESTDIR=\"${D}\" \
		USERCOMPILE=\"${CFLAGS}\"
	if use smartcard ; then
		echo USE_SMARTCARD=true
	fi
	if use extra-algorithms ; then
		echo USE_EXTRACRYPTO=true
	else
		echo USE_EXTRACRYPTO=false
	fi
	if use weak-algorithms ; then
		echo USE_WEAKSTUFF=true
		if use nocrypto-algorithms; then
			echo USE_NOCRYPTO=true
		fi
	fi
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

	newinitd "${FILESDIR}"/ipsec-initd ipsec || die "failed to install init script"

	dodir /var/run/pluto || die "failed to create /var/run/pluto"
}

pkg_preinst() {
	if has_version "<net-misc/openswan-2.6.14" && pushd "${ROOT}etc/ipsec"; then
		ewarn "Following files and directories were moved from '${ROOT}etc/ipsec' to '${ROOT}etc':"
		local i err=0
		if [ -h "../ipsec.d" ]; then
			rm "../ipsec.d" || die "failed to remove ../ipsec.d symlink"
		fi
		for i in *; do
			if [ -e "../$i" ]; then
				eerror "  $i NOT MOVED, ../$i already exists!"
				err=1
			elif [ -d "$i" ]; then
				mv "$i" .. || die "failed to move $i directory"
				ewarn "  directory $i"
			elif [ -f "$i" ]; then
				sed -i -e 's:/etc/ipsec/:/etc/:g' "$i" && \
					mv "$i" .. && ewarn "  file $i" || \
					die "failed to move $i file"
			else
				eerror "  $i NOT MOVED, it is not a file nor a directory!"
				err=1
			fi
		done
		popd
		if [ $err -eq 0 ]; then
			rmdir "${ROOT}etc/ipsec" || eerror "Failed to remove ${ROOT}etc/ipsec"
		else
			ewarn "${ROOT}etc/ipsec is not empty, you will have to remove it yourself"
		fi
	fi
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
