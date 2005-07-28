# Copyright 2005-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dmraid/dmraid-1.0.0_rc8-r1.ebuild,v 1.1 2005/07/28 02:24:07 solar Exp $

inherit linux-info flag-o-matic

DESCRIPTION="dmraid (Device-mapper RAID tool and library)"
HOMEPAGE="http://people.redhat.com/~heinzm/sw/dmraid/"
SRC_URI="http://people.redhat.com/~heinzm/sw/dmraid/src/${P/_/.}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""
DEPEND="sys-fs/device-mapper"
S=${WORKDIR}/${PN}/${PV/_/.}

pkg_setup() {
	if kernel_is lt 2 6; then
		ewarn "You are using a kernel < 2.6"
		ewarn "DMraid uses recently introduced Device-Mapper features."
		ewarn "These might be unavailable in the kernel you are running now."
	fi
}

src_compile() {
	# Build fix rc8 for shared lib
	sed -e 's:global\::global\:\ init_locking;:' -i lib/.export.sym

	#inlining doesnt seem to work for dmraid
	filter-flags -fno-inline

	# We want shared. For static boot stuff, people should use genkernel.
	./configure --enable-shared_lib || die "Failed configure"
	#econf --enable-shared_lib || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall DESTDIR=${D} || die "einstall failed"

	dolib.a lib/libdmraid.a

	# no header file is installed by make install
	insinto /usr/include
	newins include/dmraid.h libdmraid.h

	dodoc CHANGELOG README TODO KNOWN_BUGS doc/*
}

pkg_postinst() {
	echo
	einfo "For booting Gentoo from Device-Mapper RAID you can use Genkernel."
	echo
	einfo "Genkernel will generate the kernel and the initrd with a staticly linked dmraid binary:"
	einfo "emerge -av sys-kernel/genkernel"
	einfo "genkernel --dmraid --udev all"
	echo
	ewarn "DMraid should be safe to use, but no warranties can be given"
	echo
	ebeep
}
