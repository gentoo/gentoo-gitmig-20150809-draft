# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/bootsplash/bootsplash-0.6-r11.ebuild,v 1.5 2004/03/28 09:41:01 spock Exp $

IUSE=""
S=${WORKDIR}/${PF}
DESCRIPTION="Graphical backgrounds for frame buffer consoles"
HOMEPAGE="http://www.bootsplash.org/ http://linux.tkdack.com/"
SRC_URI="http://dev.gentoo.org/~spock/portage/distfiles/${PF}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND=">=media-libs/freetype-2
	media-libs/libmng
	>=sys-apps/baselayout-1.8.6.13-r1"

src_compile() {
	# compile utils
	# the util builds but the rc scripts have not been modified
	# animated boot up require patches to the baselayout package
	cd ${S}/utils

	emake -C fbmngplay || die
	emake -C fbtruetype || die
	emake -C splashutils || die

	cd ${S}
}

src_install() {
	# Splash utilities
	exeinto /sbin
	doexe utils/fbmngplay/fbmngplay{,.static}
	doexe utils/fbtruetype/fbtruetype{,.static}
	doexe misc/bootsplash_resize
	newexe utils/splashutils/splash splash.bin
	doexe misc/splash
	doexe utils/splashutils/{fbresolution,getkey,progress}

	exeinto /usr/lib/${PN}
	doexe misc/bootsplash_resizer.pl

	dodir /etc/${PN}
	cp -pR themes/* ${D}/etc/${PN}

	# link default config for boot images if not already set
	if [ ! -e ${ROOT}/etc/bootsplash/default ]; then
		use livecd \
			&& dosym ./livecd-2004.0 /etc/bootsplash/default \
			|| dosym ./gentoo /etc/bootsplash/default
	fi

	exeinto /etc/init.d
	doexe misc/bootsplash

	insinto /etc/conf.d
	doins misc/bootsplash.conf

	insinto /usr/share/${PN}
	doins kernel/*.bz2 misc/grub.conf.sample

	sed -i "s:${PN}:${PF}:g" misc/bootsplash_patch
	into /
	dosbin misc/bootsplash_patch
	fperms 0754 /sbin/bootsplash_patch
}

pkg_postinst() {
	# has to be done here so that the initrd images are created properly
	if [ "${ROOT}" = "/" ]
	then
		for THEME in `ls /etc/bootsplash`
		do
			if [ -d /etc/bootsplash/${THEME} ] && [ "${THEME}" != "default" ]
			then
				for SIZE in 800x600 1024x768 1280x1024 1600x1200
				do
					/sbin/splash -s -f \
						/etc/bootsplash/${THEME}/config/bootsplash-${SIZE}.cfg \
						> /usr/share/${PN}/initrd-${THEME}-${SIZE}
				done
			fi
		done
	fi

	echo ""
	einfo "Execute \`bootsplash_patch\` to have your kernel sources in"
	einfo "/usr/src/linux patched with the Framebuffer Bootsplash patches."
	einfo
	einfo "You can also use:"
	einfo "    bootsplash_patch /path/to/your/custom/kernel/"
	einfo "to patch your custom kernel sources."
	echo ""
	ewarn "If you have already patched the kernel then you only need to copy"
	ewarn "an initrd from /usr/share/${PN} to /boot"
	echo ""
	einfo "Run:"
	einfo "    rc-update add bootsplash default"
	einfo "to change the console images after startup"
	echo ""
	einfo "Please note that in case /sbin is a separate partition"
	einfo "you'll need to use the statically linked versions of Bootplash"
	einfo 'utilities (fbmngplay.static, fbtruetype.static) during boot-time.'
	echo ""
	einfo "If you would like to have a better quality background picture"
	einfo "from the Gentoo theme and you don't care about a few more kilobytes"
	einfo "of used memory, try the gentoo-highquality theme which you can"
	einfo "download from:"
	einfo "http://dev.gentoo.org/~spock/stuff/bootsplash/gentoo-highquality.tar.bz2"
	echo ""
	einfo "After the download is complete, unpack the files to /etc/bootsplash/"
	echo ""
	einfo "If you want to automatically generate configs for a new resolution"
	einfo "you can use the \`bootsplash_resize\` script. More info:"
	einfo "    bootsplash_resize -h"
	echo ""
}

pkg_config() {

	if [ "${LINUX}" == "" ]; then
		LINUX='/usr/src/linux'
	fi

	eval `sed -n -e 's/^\([A-Z]*\) = \([0-9]*\)$/\1=\2/p' -e 's/^\([A-Z]*\) = \(-[-a-z0-9]*\)$/\1=\2/p' ${LINUX}/Makefile`

	if [ -z "$VERSION" -o -z "$PATCHLEVEL" -o -z "$SUBLEVEL" ]
	then
		die "Unable to determine kernel version in ${LINUX}"
	fi

	KB="${VERSION}.${PATCHLEVEL}"
	KV_MINOR="${SUBLEVEL}"

	ewarn
	ewarn "Patching the kernel (branch: ${KB}) in ${LINUX} ..."
	ewarn

	cd ${ROOT}/${LINUX}

	if [ "${KB}" == "2.4" ]; then

		if [ -f drivers/video/fbcon-splash.c ]; then
			eerror
			eerror "It appears your kernel has already been patched."
			eerror
			exit 1
		fi

		if [ ${KV_MINOR} -ge 22 ]; then
			bzip2 -dc ${ROOT}/usr/share/${PN}/${PN}-3.0.7-2.4.22-vanilla.diff.bz2 \
					| patch -p1 || die
		else
			bzip2 -dc ${ROOT}/usr/share/${PN}/${PN}-3.0.7-2.4.20-vanilla.diff.bz2 \
					| patch -p1 || die
		fi

	elif [ "${KB}" == "2.6" ]; then

		if [ -d drivers/video/bootsplash ]; then
			eerror
			eerror "It appears your kernel has already been patched."
			eerror
			exit 1
		fi

		if [ ${KV_MINOR} -ge 3 ]; then
			bzip2 -dc ${ROOT}/usr/share/${PN}/${PN}-3.1.4-2.6.3.diff.bz2 \
					| patch -p1 || die
		else
			bzip2 -dc ${ROOT}/usr/share/${PN}/${PN}-3.1.3-2.6.0-test9.diff.bz2 \
					| patch -p1 || die
		fi
	else
		die "Sorry, this kernel branch is not supported."
	fi

	ewarn
	ewarn " ... complete."
	einfo
	einfo "Your kernel has been patched, rebuild with the following options"
	einfo "enabled (do not build them as modules!):"
	einfo "		Block Devices ->"
	einfo "			[*] RAM disk support"
	einfo "			[*] Loopback device support"
	einfo "			[*] Initial RAM disk (initrd) support"
	einfo
	einfo "		Console Drivers ->"
	einfo "			[*] Video mode selection support"
	einfo "			Frame-buffer support ->"
	einfo "				[*] Support for frame buffer devices"
	einfo "				[*] VESA VGA graphics console"
	einfo "				[*] Use splash screen instead of boot logo"
	einfo
	einfo "Copy an initrd from /usr/share/${PN} to /boot"
	einfo
	einfo "Look at \"/usr/share/${PN}/grub.conf.sample\" for an example"
	einfo "grub.conf file with the appropriate changes to enable the"
	einfo "framebuffer boot screens"
	einfo
	einfo "Ensure you make the appropriate changes to your grub.conf"
	einfo
}
