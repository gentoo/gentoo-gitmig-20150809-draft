# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/tuxfrw/tuxfrw-2.58-r1.ebuild,v 1.1 2005/01/27 20:29:26 angusyoung Exp $

inherit eutils kernel-mod

DESCRIPTION="TuxFrw is a complete firewall automation tool for GNU/Linux."
HOMEPAGE="http://tuxfrw.sf.net/"
SRC_URI="mirror://sourceforge/tuxfrw/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-firewall/iptables"

pkg_preinst() {
	check_KV
	kernel-mod_getversion

	#check for kernel version (2.4.18 or higher)
	if [ ${KV_MINOR} -eq 4 ]  && [ ${KV_PATCH} -lt 18 ] ; then
		eerror "${P} requires a 2.4 kernel version of at"
		eerror "least 2.4.23. You must upgrade your kernel."
		die "Kernel version not supported"
	fi
}

src_compile() {
	einfo "Nothing to compile..."
}

src_install() {

	diropts -m0700
	dodir /etc/tuxfrw
	dodir /etc/tuxfrw/rules

	insinto /etc/tuxfrw/rules
	insopts -m0600
	doins ${S}/tf_*-*.mod
	doins ${S}/tf_INPUT.mod
	doins ${S}/tf_OUTPUT.mod
	doins ${S}/tf_FORWARD.mod
	doins ${S}/tf_TOS.mod

	insinto /etc/tuxfrw
	doins ${S}/tf_PIGMEAT.mod
	doins ${S}/tf_KERNEL.mod
	doins ${S}/tf_BASE.mod
	doins ${S}/tf_ATK.mod
	doins ${S}/tuxfrw.conf

	#needs gentoo style script
	exeopts -m700
	exeinto /etc/init.d/
	doexe ${FILESDIR}/tuxfrw

	#doing binary install instead
	dosbin ${S}/tuxfrw

	# Is this really needed ?
	dodoc ${S}/AUTHORS ${S}/COPYING ${S}/CREDITS ${S}/ChangeLog ${S}/INSTALL
	dodoc ${S}/README ${S}/VERSION ${S}/manual/${PN}-manual-${PV}-en.txt
}

pkg_postinst() {
	einfo " TuxFrw installation is finished! "
	einfo " tfconf.sh is deprecated. Configure $CONF_DIR/tuxfrw.conf manually"
	einfo " to start: /etc/init.d/tuxfrw start "
	einfo " to load on boot: rc-update add tuxfrw default"
	einfo ""
	einfo "You will need to have iptables support compiled on your kernel"
	einfo "in order to this package to work. The current list of modules"
	einfo "needed can be found here:"
	einfo "http://dev.gentoo.org/~angusyoung/docs/devel/tuxfrw/mod.txt"
}

