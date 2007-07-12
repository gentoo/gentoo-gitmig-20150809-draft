# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hamachi/hamachi-0.9.9.9_p20-r2.ebuild,v 1.7 2007/07/12 02:52:15 mr_bones_ Exp $

inherit eutils linux-info

# gHamachi GUI

MY_PV=${PV/_p/-}
MY_P=${PN}-${MY_PV}-lnx

DESCRIPTION="Hamachi is a secure mediated peer to peer."
HOMEPAGE="http://hamachi.cc"
LICENSE="as-is"
SRC_URI=" !pentium? ( http://files.hamachi.cc/linux/${MY_P}.tar.gz )
	  pentium? ( http://files.hamachi.cc/linux/${MY_P}-pentium.tar.gz )"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="pentium"
RESTRICT="strip mirror"

# Set workdir for both hamachi versions
if use pentium; then
	S=${WORKDIR}/${MY_P}-pentium
else
	S=${WORKDIR}/${MY_P}
fi

pkg_preinst() {
	# Add group "hamachi" & user "hamachi"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

pkg_setup() {
	einfo "Checking your kernel configuration for TUN/TAP support."
	CONFIG_CHECK="TUN"
	check_extra_config
}

src_unpack() {
	# Unpack the correct Hamachi version
	if use !pentium; then
		unpack ${MY_P}.tar.gz
	else
		unpack ${MY_P}-pentium.tar.gz
	fi
}

src_compile() {
	# Compile Tuncfg
	make -sC ${S}/tuncfg || die "Compiling of tunecfg failed"
}

src_install() {
	# Hamachi
	einfo "Installing Hamachi"
	insinto /usr/bin
	insopts -m0755
	doins hamachi
	dosym /usr/bin/hamachi /usr/bin/hamachi-init

	# Tuncfg
	einfo "Installing Tuncfg"
	insinto /usr/sbin
	insopts -m0700
	doins tuncfg/tuncfg

	# Create log directory
	dodir /var/log/${PN}

	# Config files
	einfo "Installing config files"
	newinitd ${FILESDIR}/tuncfg.initd tuncfg
	newconfd ${FILESDIR}/hamachi.confd hamachi
	newinitd ${FILESDIR}/hamachi.initd hamachi

	# Docs
	dodoc CHANGES README LICENSE LICENSE.openssh LICENSE.openssl LICENSE.tuncfg

}

pkg_postinst() {
	if use pentium; then
	einfo "Remember, you set the pentium USE flag!"
	einfo So, you installed the version for older x86 systems!
	einfo If your CPU is greater than Intel Pentium / AMD K6,
	einfo remove the pentium USE flag and try this version!
	fi

	if use !pentium; then
	ewarn "If you are seeing 'illegal instruction' error when trying"
	ewarn "to run Hamachi client, set the pentium USE flag!"
	ewarn "It enables binaries built specifically for older"
	ewarn "x86 platforms, like Intel Pentium or AMD K6,"
	ewarn "with all optimizations turned off."
	fi

	einfo "To start Hamachi just type:"
	einfo "/etc/init.d/hamachi start"
}
