# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-2.0.6.ebuild,v 1.9 2006/04/24 07:34:26 uberlord Exp $

inherit eutils gnuconfig multilib

DESCRIPTION="OpenVPN is a robust and highly flexible tunneling application compatible with many OSes."
SRC_URI="http://openvpn.net/release/openvpn-${PV}.tar.gz"
HOMEPAGE="http://openvpn.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc-macos sparc x86"
IUSE="examples iproute2 minimal pam passwordsave selinux ssl static threads"

RDEPEND=">=dev-libs/lzo-1.07
	kernel_linux? (
		iproute2? ( sys-apps/iproute2 ) !iproute2? ( sys-apps/net-tools )
	)
	!minimal? ( pam? ( virtual/pam ) )
	selinux? ( sec-policy/selinux-openvpn )
	ssl? ( >=dev-libs/openssl-0.9.6 )"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_unpack() {
	unpack "${A}"
	gnuconfig_update
	cd "${S}"
	epatch "${FILESDIR}/${PN}"-2.0.4-darwin.patch
}

src_compile() {
	local myconf=""
	# We cannot use use_enable with iproute2 as the Makefile stupidly
	# enables it with --disable-iproute2
	use iproute2 && myconf="${myconf} --enable-iproute2"
	use minimal && myconf="${myconf} --disable-plugins"

	econf ${myconf} \
		$(use_enable passwordsave password-save) \
		$(use_enable ssl) \
		$(use_enable ssl crypto) \
		$(use_enable threads pthread) \
		|| die "configure failed"

	use static && sed -e -i '/^LIBS/s/LIBS = /LIBS = -static /' Makefile

	emake || die "make failed"

	if ! use minimal ; then
		cd plugin
		for i in $( ls 2>/dev/null ); do
			[[ ${i} == "README" || ${i} == "examples" ]] && continue
			[[ ${i} == "auth-pam" ]] && ! use pam && continue
			einfo "Building ${i} plugin"
			cd "${i}"
			emake || die "make failed"
			cd ..
		done
		cd ..
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# install documentation
	dodoc AUTHORS ChangeLog PORTS README

	# Empty dir
	dodir /etc/openvpn
	keepdir /etc/openvpn

	# Install the init script
	newinitd "${FILESDIR}/openvpn.init" openvpn

	# install examples, controlled by the respective useflag
	if use examples ; then
		# dodoc does not supportly support directory traversal, #15193
		insinto /usr/share/doc/${PF}/examples
		doins -r sample-{config-files,keys,scripts} contrib
		prepalldocs
	fi

	# Install plugins and easy-rsa
	if ! use minimal ; then
		cd easy-rsa/2.0
		exeinto "/usr/share/${PN}/easy-rsa"
		doexe *-* pkitool
		insinto "/usr/share/${PN}/easy-rsa"
		doins README openssl.cnf vars
		cd ../..

		exeinto "/usr/$(get_libdir)/${PN}"
		doexe plugin/*/*.so
	fi
}

pkg_postinst() {
	ewarn "WARNING: The openvpn init script has changed"
	ewarn ""
	einfo "The openvpn init script expects to find the configuration file"
	einfo "openvpn.conf in /etc/openvpn along with any extra files it may need."
	einfo ""
	einfo "To create more VPNs, simply create a new .conf file for it and"
	einfo "then create a symlink to the openvpn init script from a link called"
	einfo "openvpn.newconfname - like so"
	einfo "   cd /etc/openvpn"
	einfo "   ${EDITOR##*/} foo.conf"
	einfo "   cd /etc/init.d"
	einfo "   ln -s openvpn openvpn.foo"
	einfo ""
	einfo "You can then treat openvpn.foo as any other service, so you can"
	einfo "stop one vpn and start another if you need to."
	if ! use minimal ; then
		einfo ""
		einfo "plugins have been installed into /usr/$(get_libdir)/${PN}"
	fi
	einfo ""
	einfo "It is recommended that you create your tun/tap interfaces using"
	einfo "the net.tun0/net.tap0 scripts provided by baselayout instead of"
	einfo "using the 'server' directive in openvpn configuration files."
	einfo "This will insure that the interface really is up after openvpn"
	einfo "starts."
	einfo "Note that you cannot use net.tun0/net.tap0 and the server option,"
	einfo "otherwise openvpn will not start."
	ebeep
}
