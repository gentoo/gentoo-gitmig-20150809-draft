# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/bootsplash/bootsplash-0.6.1-r3.ebuild,v 1.2 2004/07/20 14:49:24 spock Exp $

IUSE=""
S=${WORKDIR}
DESCRIPTION="Graphical backgrounds for frame buffer consoles"
HOMEPAGE="http://www.bootsplash.org/ http://linux.tkdack.com/"
SRC_URI="http://dev.gentoo.org/~spock/portage/distfiles/${PN}-core-0.6.1-r3.tar.bz2
	http://dev.gentoo.org/~spock/portage/distfiles/${PN}-themes-0.6.1.tar.bz2
	http://dev.gentoo.org/~spock/portage/distfiles/${PN}-kernel-0.6.1-r3.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

DEPEND=">=media-libs/freetype-2
	media-libs/libmng"

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
		dosym ./gentoo /etc/bootsplash/default
	fi

	exeinto /etc/init.d
	doexe misc/bootsplash

	insinto /etc/conf.d
	newins misc/bootsplash.conf bootsplash

	insinto /usr/share/${PN}
	doins kernel/*.bz2 misc/grub.conf.sample

	into /
	dosbin misc/bootsplash_patch misc/bootsplash_initrdgen
	fperms 0754 /sbin/bootsplash_patch /sbin/bootsplash_initrdgen
}

pkg_postinst() {
	# has to be done here so that the initrd images are created properly
	if [ "${ROOT}" = "/" ]
	then
		/sbin/bootsplash_initrdgen --all
	fi

	# rename bootsplash config file to fit with the standard
	if [ -f ${ROOT}/etc/conf.d/bootsplash.conf ]
	then
		mv -f ${ROOT}/etc/conf.d/bootsplash.conf ${ROOT}/etc/conf.d/bootsplash
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
	einfo "If you want to automatically generate configs for a new resolution"
	einfo "you can use the \`bootsplash_resize\` script. More info:"
	einfo "    bootsplash_resize -h"
	echo ""
}
