# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/bootsplash/bootsplash-0.3.ebuild,v 1.2 2003/02/13 12:31:13 vapier Exp $

DESCRIPTION="Graphical backgrounds for frame buffer consoles"

HOMEPAGE="http://linux.tkdack.com"

SRC_URI="http://gentoo.tkdack.com/downloads/gentoo/bootsplash-${PV}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=""

RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	# compile splashutil
	cd ${S}/splashutil
	make || die
	# compile bootsplash-config maker
	cd ${S}/bootsplash-config
	make || die
	# create config files for different resolutions
	sh bootsplash-config.sh
}

src_install() {
	
	exeinto /usr/bin
	doexe ${S}/splashutil/splash
	doexe ${S}/bootsplash-config/bootsplash-config
	
	insinto /usr/share/${P}
	doins ${S}/bootsplash-config/*.cfg
	doins ${S}/*.jpg
	
	# link default config
	dosym ./gentoo-boot-1280x1024.jpg /usr/share/${P}/bootsplash.jpg
	dosym ./gentoo-boot-1280x1024.cfg /usr/share/${P}/bootsplash.cfg
	
	doins ${S}/boot_splash_complete.2.4.19-vanilla.patch
	doins ${S}/grub.conf.sample
	
	insinto /etc/conf.d
	doins ${S}/local.start
	doins ${S}/local.stop	

	dodoc README
	dodoc COPYING
	dodoc CREDITS

	# generate initial initrd file
	${S}/splashutil/splash -s -f ${D}/usr/share/${P}/bootsplash.cfg > ${D}/usr/share/${P}/initrd
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/media-gfx/${P}/${P}.ebuild config\""
	einfo "to have your kernel sources in /usr/src/linux patched with the"
	einfo "Framebuffer Bootsplash patches"
	einfo
	echo ""
	ewarn "If you have already patched the kernel then you only need to copy"
	ewarn "the initrd from /usr/share/${P}/initrd to /boot"
	ewarn
	echo ""
	einfo
	einfo "Please \"merge\" any changed files in /etc/conf.d"
	einfo
}

pkg_config() {
	ewarn
	ewarn "Patching the kernel in /usr/src/linux ..."
	ewarn
	cd ${ROOT}/usr/src/linux
	cat ${ROOT}/usr/share/${P}/boot_splash_complete.2.4.19-vanilla.patch | patch -p1 || die
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
	einfo "Copy /usr/share/${P}/initrd to /boot"
	einfo
	einfo "Look at \"/usr/share/${P}/grub.conf.sample\" for an example"
	einfo "grub.conf file with the appropriate changes to enable the"
	einfo "framebuffer boot screens"
	einfo
	einfo "Ensure you make the appropriate changes to your grub.conf"
	einfo
}

