# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/pbbuttonsd/pbbuttonsd-0.7.2.ebuild,v 1.4 2006/01/30 02:44:35 josejx Exp $

inherit eutils flag-o-matic

DESCRIPTION="program to map special Powerbook/iBook keys"
HOMEPAGE="http://pbbuttons.sf.net"
SRC_URI="mirror://sourceforge/pbbuttons/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~x86"
IUSE="acpi debug alsa oss"

DEPEND=">=sys-apps/baselayout-1.8.6.12-r1"
RDEPEND="alsa? ( >=media-libs/alsa-lib-1.0 )"

src_compile() {
	# Fix crash bug on some systems
	replace-flags -O? -O1

	if use x86; then
		if use acpi; then
			laptop=acpi
		else
			laptop=i386
		fi
	else
		laptop=powerbook
	fi

	econf laptop=$laptop \
		$(use_enable debug) \
		$(use_enable alsa) \
		$(use_enable oss) \
		|| die "Sorry, failed to configure pbbuttonsd"
	emake || die "Sorry, failed to compile pbbuttonsd"
}

src_install() {
	dodir /etc/power
	make DESTDIR=${D} install || die "failed to install"
	exeinto /etc/init.d
	newexe ${FILESDIR}/pbbuttonsd.rc6 pbbuttonsd
	dodoc README
}

pkg_postinst() {
	ewarn "Ensure that the evdev kernel module is loaded or built in"
	ewarn "pbbuttonsd won't work without it."
	einfo

	if use ppc; then
	einfo
	einfo "This version of pbbuttonsd can replace PMUD functionality."
	einfo "If you want PMUD installed and running, you should set"
	einfo "replace_pmud=no in /etc/pbbuttonsd.conf. Otherwise you can"
	einfo "try setting replace_pmud=yes in /etc/pbbuttonsd.conf and"
	einfo "disabling PMUD"
	einfo
	ewarn "Warning: the NoTapTyping option is unstable, see bug #86768."
	fi
}
