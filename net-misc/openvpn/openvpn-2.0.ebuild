# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-2.0.ebuild,v 1.5 2005/06/18 21:09:42 weeve Exp $

inherit gnuconfig

DESCRIPTION="OpenVPN is a robust and highly flexible tunneling application compatible with many OSes."
SRC_URI="http://openvpn.net/release/openvpn-${PV}.tar.gz"
HOMEPAGE="http://openvpn.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc-macos sparc x86"
IUSE="examples ssl threads"

RDEPEND=">=dev-libs/lzo-1.07
	ssl? ( >=dev-libs/openssl-0.9.6 )"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_unpack() {
	unpack ${A}
	gnuconfig_update
}

src_compile() {
	econf \
		$(use_enable ssl) \
		$(use_enable ssl crypto) \
		$(use_enable threads pthread) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# install documentation
	dodoc AUTHORS ChangeLog INSTALL PORTS README

	# Empty dir
	dodir /etc/openvpn
	keepdir /etc/openvpn

	# Install upstream init script for Gentoo
	sed -i "s:/usr/local:/usr:" gentoo/openvpn.init
	newinitd ${S}/gentoo/openvpn.init openvpn

	# Install easy-rsa stuffs
	dodir /usr/share/${PN}/easy-rsa
	exeinto /usr/share/${PN}/easy-rsa
	doexe easy-rsa/*
	exeopts -m0644

	# install examples, controlled by the respective useflag
	if use examples; then
		local sampledir="/usr/share/doc/${PN}/examples"
		dodir ${sampledir}

		cp -r sample-{config-files,keys,scripts} ${D}${sampledir}
		cp -r contrib/ ${D}${sampledir}
	fi
}

pkg_postinst() {
	einfo "The init.d script that comes with OpenVPN now expects"
	einfo "configuration files and all supporting files such as keys"
	einfo "in /etc/openvpn."
	ewarn "This version of OpenVPN is NOT COMPATIBLE with older versions!"
	ewarn "If you need compatibility with a version < 2 please emerge"
	ewarn "that one."
}
