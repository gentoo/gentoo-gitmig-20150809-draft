# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/arcboot/arcboot-0.3.8.6-r1.ebuild,v 1.2 2007/06/26 02:49:41 mr_bones_ Exp $

inherit eutils

MY_P="${P/-/_}"
ARCVER="1.1"		# Version of the arcboot patch ball

DESCRIPTION="ARCS Bootloader for SGI Machines (IP22, IP32)"
HOMEPAGE="http://packages.qa.debian.org/a/arcboot.html"
SRC_URI="http://http.us.debian.org/debian/pool/main/a/arcboot/${MY_P}.tar.gz
		mirror://gentoo/arcboot-patches-${ARCVER}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~mips"
IUSE="ip27 ip28 ip30 cobalt"

DEPEND=""
RDEPEND="sys-boot/dvhtool
	 sys-apps/debianutils"

S=${WORKDIR}/${PN}

pkg_setup() {
	# arcboot is for SGI mips machines only, so exclude everyone but them
	if use cobalt; then
		eerror "Arcboot is a bootloader only for MIPS machines running"
		eerror "ARCS firmware, such as SGI Machines.  It is not intended"
		eerror "for other kinds of MIPS machines."
		die "Wrong MIPS Machine Type"
	fi

	# Machines which expect an ELF64 binary to boot can't use arcboot
	if use ip27 || use ip28 || use ip30; then
		eerror "Arcboot does not work on systems that can only boot pure 64bit"
		eerror "ELF binaries.  Arcboot needs some work to be able to compile as"
		eerror "an ELF64 object.  Patches are welcome!"
		die "No ELF64 Support"
	fi


	# Set SGITYPE properly
	case "$(uname -i)" in
		"SGI IP32"|"SGI O2")		SGITYPE="IP32" ;;
		"SGI Indy"|"SGI Indigo2")	SGITYPE="IP22" ;;
		*)
			eerror "Unknown SGI Machine type.  It's possible arcboot is not usable for this machine"
			eerror "type yet.  Feel free to make it work and send patches!"
			die "Unknown SGI Machine Type"
			;;
	esac

	# Lower case SGITYPE
	SGITYPE_L="$(echo "${SGITYPE}" | tr [A-Z] [a-z])"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Set the version
	echo "#define __ARCSBOOT_VERSION__ \"${PV}\"" > common/version.h

	# Crazy patches.  One is onion's patch, highly modified, from:
	# http://www.tal.org/~milang/o2/
	#
	# Second is a clean up of bits in onion's patch to make it
	# compile against our headers.
	epatch ${WORKDIR}/patches/${P}-makefile.patch
	epatch ${WORKDIR}/patches/${P}-segaddr.patch
}

src_compile() {
	cd ${S}

	echo -e ""
	einfo ">>> Building for ${SGITYPE} ..."
	echo -e ""

	make SUBARCH="${SGITYPE}" || die
}

src_install() {
	cd ${S}

	# Arcboot
	dodir /usr/lib/arcboot
	cp ext2load/ext2load ${D}/usr/lib/arcboot/arcboot.${SGITYPE_L}

	# Technically, we don't need tip[2|3]2 (attaches initrd to kernel), as
	# MIPS kernels support embedding initrd's into kernels at build time,
	# But maybe this will be useful one day.  Until then, we leave it out.
	dodir /usr/lib/tip22
	cp tip22/t${SGITYPE_L} ${D}/usr/lib/tip22
	cp tip22/tftpload.${SGITYPE}.o ${D}/usr/lib/tip22
	cp tip22/ld.kernel.script.${SGITYPE} ${D}/usr/lib/tip22
	cp tip22/ld.ramdisk.script.${SGITYPE} ${D}/usr/lib/tip22
	cp tip22/ld.script ${D}/usr/lib/tip22
	cp arclib/libarc.a ${D}/usr/lib/tip22

	# Calling scripts for arcboot/tip22
	# We also exclude these, since the logic in the debian script may not
	# work correctly with a gentoo installation.  All the information a
	# user needs is provided in the example arcboot.conf, and in pkg_postinst().
##	dosbin scripts/arcboot
	dosbin tip22/t${SGITYPE_L}

	# Conf file
	dodir /etc
	cp etc/arcboot.conf ${D}/etc/arcboot.conf.example

	# Man pages
	# The arcboot manpage is more for the excluded arcboot script above, but
	# also has info on setting the PROM option properly as well as arcboot.conf
	# examples.
	doman debian/arcboot.8
	doman debian/t${SGITYPE_L}.8
}

pkg_postinst() {
	echo -e ""
	einfo "The arcboot image used to load the kernel from disk has been stored in"
	einfo "/usr/lib/arcboot/arcboot.${SGITYPE}.  To use it, you need to copy this into"
	einfo "the volume header with dvhtool:"
	einfo ""
	einfo "dvhtool --unix-to-vh /usr/lib/arcboot/arcboot.${SGITYPE} arcboot"
	echo -e ""
	einfo "Next, you need to create an arcboot.conf file.  An example arcboot.conf"
	einfo "file has been placed in /etc."
	echo -e ""
	echo -e ""
	ewarn "NOTE: If you put kernels in /boot for arcboot to load, and /boot is on a"
	ewarn "      separate partition, then arcboot.conf MUST go into /boot/etc, and a"
	ewarn "      symlink must be created to point /boot back to itself:"
	ewarn ""
	ewarn "      cd /boot; ln -sf . boot"
	echo -e ""
	einfo "To use arcboot, from the PROM Monitor, simply type \"arcboot\" or \"boot -f arcboot\"."
	echo -e ""
	echo -e ""
}
