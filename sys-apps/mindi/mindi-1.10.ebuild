# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mindi/mindi-1.10.ebuild,v 1.1 2004/08/12 21:30:21 pfeifer Exp $

RESTRICT="nouserpriv"
DESCRIPTION="A program that creates emergency boot disks/CDs using your kernel, tools and modules."
HOMEPAGE="http://www.mondorescue.org/"
SRC_URI="http://www.microwerks.net/~hugo/download/MondoCD/TGZS/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE=""

DEPEND=""
RDEPEND=">=app-arch/bzip2-0.9
		>=sys-apps/mindi-kernel-1.0-r1
		app-cdr/cdrtools
		sys-libs/ncurses
		sys-devel/binutils
		sys-apps/gawk"

pkg_setup () {
	for i in ${FEATURES} ; do
		if [ "${i}" = "userpriv" ] ; then
			echo
			ewarn "mindi cannot be installed if userpriv"
			ewarn "is set within FEATURES."
			ewarn "Please emerge mindi as follows:"
			echo
			ewarn "# FEATURES=\"-userpriv\" emerge mindi"
			die "userpriv failure"
		fi
	done
}

src_unpack() {
	unpack ${A} || die "Failed to unpack ${A}"
	cd ${S}/rootfs || die
	tar xzf symlinks.tgz || die "Failed to unpack symlinks.tgz"

	# This will need to change when IA64 is tested. Onviously.
	rm -f bin/busybox-ia64 sbin/parted2fdisk-ia64
	mv bin/busybox-i386 bin/busybox
}

src_install() {
	dodir /usr/sbin

	dodir /usr/share/mindi
	exeinto /usr/share/mindi
	doexe analyze-my-lvm mindi parted2fdisk.pl

	dosym /usr/share/mindi/mindi /usr/sbin/

	insinto /usr/share/mindi
	doins deplist.txt isolinux-H.cfg isolinux.cfg \
	msg-txt sys-disk.raw.gz syslinux-H.cfg syslinux.cfg

	cp -a Mindi/ aux-tools/ rootfs/ ${D}/usr/share/mindi/

	dodoc CHANGES INSTALL README TODO
}

pkg_postinst() {
	einfo "${P} was successfully installed."
	einfo "Please read the associated docs for help."
	einfo "Or visit the website @ ${HOMEPAGE}"
	echo
	ewarn "This package is still in unstable."
	ewarn "Please report bugs to http://bugs.gentoo.org/"
	ewarn "However, please do an advanced query to search for bugs"
	ewarn "before reporting. This will keep down on duplicates."
	echo
}
