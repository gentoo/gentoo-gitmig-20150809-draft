# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/bootsplash/bootsplash-0.6.ebuild,v 1.1 2003/04/21 01:25:48 tad Exp $

DESCRIPTION="Graphical backgrounds for frame buffer consoles"

HOMEPAGE="http://linux.tkdack.com"

SRC_URI="mirror://gentoo/bootsplash-${PV}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=media-libs/freetype-2"

# Not implemented yet
#		media-libs/libmng"

RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {

	# compile utils

# mng is not implmented yet
# (the util builds but the rc scripts have not been modified)
#	cd ${S}/utils/fbmngplay
#	emake fbmngplay || die

	cd ${S}/utils/fbtruetype
	emake || die

	cd ${S}/utils/splashutils
	emake || die

}

src_install() {
	
	# Splash utilities
	exeinto /sbin
#	doexe ${S}/utils/fbmngplay/fbmngplay
	doexe ${S}/utils/fbtruetype/fbtruetype
	doexe ${S}/utils/fbtruetype/fbtruetype.static
	doexe ${S}/utils/splashutils/splash
	doexe ${S}/utils/splashutils/fbresolution
	doexe ${S}/utils/splashutils/getkey

	mkdir -p ${D}/etc/${PN}
	cp -pR ${S}/themes/* ${D}/etc/${PN}

	# link default config - for boot images
	dosym  ./gentoo /etc/bootsplash/default

	insinto /etc/init.d
	doins ${S}/misc/bootsplash
	fperms 755 /etc/init.d/bootsplash

	insinto /etc/conf.d
	doins ${S}/misc/bootsplash.conf

	insinto /usr/share/${PN}
	doins ${S}/kernel/bootsplash-3.0.7-2.4.20-vanilla.diff
	doins ${S}/misc/grub.conf.sample

#	dodoc README
#	dodoc COPYING
#	dodoc CREDITS

}

pkg_postinst() {
	# Has to be done here so that the initrd images are created properly
	for SIZE in 800x600 1024x768 1280x1024
	do
		/sbin/splash -s -f /etc/bootsplash/gentoo/config/bootsplash-${SIZE}.cfg > /usr/share/${PN}/initrd-${SIZE}
	done

	einfo
	einfo "Execute \"ebuild /var/db/pkg/media-gfx/${PN}/${P}.ebuild config\""
	einfo "to have your kernel sources in /usr/src/linux patched with the"
	einfo "Framebuffer Bootsplash patches"
	einfo
	echo ""
	ewarn "If you have already patched the kernel then you only need to copy"
	ewarn "an initrd from /usr/share/${PN} to /boot"
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
	patch -p1 < ${ROOT}/usr/share/${PN}/bootsplash-3.0.7-2.4.20-vanilla.diff || die
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
