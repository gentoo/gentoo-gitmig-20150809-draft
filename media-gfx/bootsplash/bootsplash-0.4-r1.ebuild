# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/bootsplash/bootsplash-0.4-r1.ebuild,v 1.1 2003/03/19 13:43:56 tad Exp $

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
}

src_install() {
	
	exeinto /usr/bin
	doexe ${S}/splashutil/splash
	
	# Should install into /usr/share/bootsplash (I hope)
	insinto /usr/share/${PN}
	doins ${S}/*.jpg
	doins ${S}/*.cfg
	
	# link default config - for boot images
	dosym ./gentoo-boot-1280x1024.jpg /usr/share/${PN}/bootsplash.jpg
	dosym ./gentoo-boot-1280x1024.cfg /usr/share/${PN}/bootsplash.cfg

	# link default config - for console images
	dosym ./gentoo-console-1280x1024.jpg /usr/share/${PN}/consolesplash.jpg
	dosym ./gentoo-console-1280x1024.cfg /usr/share/${PN}/consolesplash.cfg
	
	doins ${S}/boot_splash_complete.2.4.19-vanilla.patch
	doins ${S}/grub.conf.sample
	
	insinto /etc/init.d
	doins ${FILESDIR}/bootsplash
	fperms 755 /etc/init.d/bootsplash

	dodoc README
	dodoc COPYING
	dodoc CREDITS

	# generate initial initrd file
	${S}/splashutil/splash -s -f ${D}/usr/share/${PN}/bootsplash.cfg > ${D}/usr/share/${PN}/initrd
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/media-gfx/${PN}/${P}.ebuild config\""
	einfo "to have your kernel sources in /usr/src/linux patched with the"
	einfo "Framebuffer Bootsplash patches"
	einfo
	echo ""
	ewarn "If you have already patched the kernel then you only need to copy"
	ewarn "the initrd from /usr/share/${PN}/initrd to /boot"
	ewarn
	echo ""
	einfo
	einfo "Run:"
	einfo "    rc-update add bootsplash default"
	einfo " to change the console images after startup"
	einfo
}

pkg_config() {
	ewarn
	ewarn "Patching the kernel in /usr/src/linux ..."
	ewarn
	cd ${ROOT}/usr/src/linux
	patch -p1 < ${ROOT}/usr/share/${PN}/boot_splash_complete.2.4.19-vanilla.patch || die
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
	einfo "Copy /usr/share/${PN}/initrd to /boot"
	einfo
	einfo "Look at \"/usr/share/${PN}/grub.conf.sample\" for an example"
	einfo "grub.conf file with the appropriate changes to enable the"
	einfo "framebuffer boot screens"
	einfo
	einfo "Ensure you make the appropriate changes to your grub.conf"
	einfo
}
