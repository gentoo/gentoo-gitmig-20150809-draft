# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/arcboot/arcboot-0.3.8.4.ebuild,v 1.2 2004/10/19 05:52:21 kumba Exp $

inherit eutils

MY_P="${P/-/_}"

DESCRIPTION="ARCS Bootloader for SGI Machines (IP22, IP32)"
HOMEPAGE="http://packages.qa.debian.org/a/arcboot.html"
SRC_URI="http://http.us.debian.org/debian/pool/main/a/arcboot/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~mips"
IUSE="cobalt"

DEPEND=""
RDEPEND="sys-boot/dvhtool
	 sys-apps/debianutils"

S=${WORKDIR}/${P}

pkg_setup() {
	# arcboot is for SGI mips machines only, so exclude everyone but them
	if use mips; then
		if use cobalt; then
			eerror "arcboot is a bootloader only for MIPS machines running"
			eerror "ARCS firmware, such as SGI Machines.  It is not intended"
			eerror "for other kinds of MIPS machines."
			die "Wrong MIPS Machine Type"
		fi
	fi


	# Set SGI_TARGET properly
	case "$(uname -i)" in
		"SGI IP32"|"SGI O2")		SGI_TARGET="ip32" ;;
		"SGI Indy"|"SGI Indigo2")	SGI_TARGET="ip22" ;;
		*)
			eerror "Unknown SGI Machine type.  It's possible arcboot is not usable for this machine"
			eerror "type yet.  Feel free to make it work and send patches!"
			die "Unknown SGI Machine Type"
			;;
	esac
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Set the version
	echo "#define __ARCSBOOT_VERSION__ \"${PV}\"" >> common/version.h

	# Last time we tested, the O2's PROM did not like an ECOFF formatted 
	# arcboot binary.
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	cd ${S}
	local sgitype="$(echo "${SGI_TARGET}" | tr [a-z] [A-Z])"

	echo -e ""
	einfo ">>> Building for ${sgitype} ..."
	echo -e ""

	make SUBARCH="${sgitype}" || die
}

src_install() {
	cd ${S}

	# Arcboot
	dodir /usr/lib/arcboot
	cp ext2load/ext2load ${D}/usr/lib/arcboot/arcboot.${SGI_TARGET}

	# Technically, we don't need tip22 (attaches initrd to kernel), as 
	# MIPS kernels support embedding initrd's into kernels at build time,
	# But maybe this will be useful one day.  Until then, we leave it out.
##	dodir /usr/lib/tip22
##	cp tip22/tip22 ${D}/usr/lib/tip22
##	cp tip22/tftpload.o ${D}/usr/lib/tip22
##	cp tip22/ld.kernel.script ${D}/usr/lib/tip22
##	cp tip22/ld.ramdisk.script ${D}/usr/lib/tip22
##	cp tip22/ld.script ${D}/usr/lib/tip22
##	cp arclib/libarc.a ${D}/usr/lib/tip22

	# Calling scripts for arcboot/tip22
	# We also exclude these, since the logic in the debian script may not
	# work correctly with a gentoo installation.  All the information a 
	# user needs is provided in the example arcboot.conf, and in pkg_postinst().
##	dosbin scripts/arcboot
##	dosbin tip22/tip22

	# Conf file
	dodir /etc
	cp etc/arcboot.conf ${D}/etc/arcboot.conf.example

	# Man pages
	# The arcboot manpage is more for the excluded arcboot script above, but 
	# also has info on setting the PROM option properly as well as arcboot.conf
	# examples.
	doman debian/arcboot.8
##	doman debian/tip22.8
}

pkg_postinst() {
	echo -e ""
	einfo "The arcboot image used to load the kernel from disk has been stored in"
	einfo "/usr/lib/arcboot/arcboot.${SGI_TARGET}.  To use it, you need to copy this into"
	einfo "the volume header with dvhtool:"
	einfo ""
	einfo "dvhtool --unix-to-vh /usr/lib/arcboot/arcboot.${SGI_TARGET} arcboot"
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
