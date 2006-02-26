# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/pbbuttonsd/pbbuttonsd-0.7.3.ebuild,v 1.2 2006/02/26 02:00:03 josejx Exp $

inherit eutils flag-o-matic

DESCRIPTION="Handles power management and special keys on laptops."
HOMEPAGE="http://pbbuttons.sf.net"
SRC_URI="mirror://sourceforge/pbbuttons/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~x86"
IUSE="acpi debug alsa oss ibam"

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
		$(use_with debug) \
		$(use_with alsa) \
		$(use_with oss) \
		$(use_with ibam) \
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
	ewarn "Ensure that the evdev kernel module is loaded or built in, otherwise"
	ewarn "pbbuttonsd won't work."
	einfo

	if use ppc ; then
		einfo "It's recommended that you let pbbuttonsd act as the low level"
		einfo "power manager instead of using pmud."
		einfo
	fi
	if use ibam; then
		einfo "To properly initialize the IBaM battery database, you will"
		einfo "need to perform a full discharge/charge cycle.  For more"
		einfo "details, please see the pbbuttonsd man page."
		einfo
	fi
	ewarn "Warning: the NoTapTyping option is unstable, see bug #86768."
}
