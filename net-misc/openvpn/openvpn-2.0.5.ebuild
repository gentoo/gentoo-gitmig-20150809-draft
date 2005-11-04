# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-2.0.5.ebuild,v 1.5 2005/11/04 14:44:25 gustavoz Exp $

inherit eutils gnuconfig multilib

DESCRIPTION="OpenVPN is a robust and highly flexible tunneling application compatible with many OSes."
SRC_URI="http://openvpn.net/release/openvpn-${PV}.tar.gz"
HOMEPAGE="http://openvpn.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ppc-macos sparc x86"
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
	dodoc AUTHORS ChangeLog INSTALL PORTS README

	# Empty dir
	dodir /etc/openvpn
	keepdir /etc/openvpn

	# Install the init script
	newinitd "${FILESDIR}/openvpn" openvpn

	# Install easy-rsa stuff
	exeinto "/usr/share/${PN}/easy-rsa"
	doexe easy-rsa/2.0/*-*
	insinto "/usr/share/${PN}/easy-rsa"
	doins easy-rsa/2.0/{README,openssl.cnf,vars}

	# install examples, controlled by the respective useflag
	if use examples ; then
		# dodoc does not supportly support directory traversal, #15193
		insinto /usr/share/doc/${PF}/examples
		doins -r sample-{config-files,keys,scripts} contrib
		prepalldocs
	fi

	# Install plugins
	if ! use minimal ; then
		exeinto "/usr/$(get_libdir)/${PN}"
		doexe plugin/*/*.so
	fi
}

pkg_postinst() {
	ewarn "This version of OpenVPN is NOT COMPATIBLE with older versions!"
	ewarn "If you need compatibility with a version < 2 please emerge"
	ewarn "that one."
	einfo ""
	einfo "The init.d script that comes with OpenVPN expects directories"
	einfo "/etc/openvpn/*/ with a local.conf and any supporting files,"
	einfo "such as keys."
	einfo ""
	ewarn "If you've used 2.0 already make sure to move your configuration"
	ewarn "files into a subdirectory of /etc/openvpn, for example to:"
	ewarn "/etc/openvpn/myconf and rename your configfile to local.conf"
	ewarn ""
	ebeep
}
