# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splashutils/splashutils-1.1.9.3.ebuild,v 1.1 2005/03/28 20:52:45 spock Exp $

MISCSPLASH="miscsplashutils-0.1.3"
GENTOOSPLASH="splashutils-gentoo-0.1.7"
KLIBC_VERSION="0.199"

DESCRIPTION="Framebuffer splash utilities."
HOMEPAGE="http://dev.gentoo.org/~spock/"
SRC_URI="mirror://gentoo/${P/_/-}.tar.bz2
	 mirror://gentoo/${GENTOOSPLASH}.tar.bz2
	 mirror://gentoo/${MISCSPLASH}.tar.bz2
	 mirror://gentoo/fbsplash-theme-emergence-r2.tar.bz2
	 mirror://gentoo/fbsplash-theme-gentoo-r1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="hardened"
RDEPEND=">=media-libs/freetype-2
	>=media-libs/libpng-1.2.7
	>=media-libs/jpeg-6b
	>=sys-apps/baselayout-1.9.4-r5
	!media-gfx/bootsplash"
DEPEND="${RDEPEND}
	virtual/linux-sources"

S="${WORKDIR}/${P/_/-}"
SG="${WORKDIR}/${GENTOOSPLASH}"
SM="${WORKDIR}/${MISCSPLASH}"

pkg_setup() {
	if use hardened; then
		ewarn "Due to problems with klibc, it is currently impossible to compile splashutils"
		ewarn "with 'hardened' GCC flags. As a workaround, the package will be compiled with"
		ewarn "-fno-stack-protector. Hardened GCC features will not be used while building"
		ewarn "the fbsplash kernel helper."
	fi
}

src_unpack() {
	unpack ${A}
	ln -s /usr/src/linux ${S}/linux
	if [[ ! -e /usr/src/linux/include/linux/console_splash.h ]]; then
		eerror "Your kernel in /usr/src/linux has not been patched with a compatible version"
		eerror "of fbsplash. Please download the latest patch from http://dev.gentoo.org/~spock/"
		eerror "and patch your kernel."
		die "Fbsplash not found"
	fi

	if [ ! -e /usr/src/linux/include/asm ]; then
		if [ -z "${KBUILD_OUTPUT}" ] ||
		   [ ! -e "${KBUILD_OUTPUT}/include/asm" ]; then
			eerror "It appears that your kernel has not been configured. Please run at least"
			eerror "\`make prepare\` before merging splashutils."
			die "Kernel not configured"
		else
			t=$(readlink ${KBUILD_OUTPUT}/include/asm)
			ln -s /usr/src/linux/include/${t} ${T}/asm
		fi
	fi

	# this should make this version of splashutils compile on hardened systems
	if use hardened; then
		sed -e 's@K_CFLAGS =@K_CFLAGS = -fno-stack-protector@' -i ${S}/Makefile
		sed -e 's@CFLAGS  =@CFLAGS  = -fno-stack-protector@' -i ${S}/libs/klibc-${KLIBC_VERSION}/klibc/MCONFIG
	fi

	mkdir ${S}/kernel
}

src_compile() {
	local miscincs

	if [ -n "${KBUILD_OUTPUT}" ]; then
		miscincs="-I${T} -I${KBUILD_OUTPUT}/include"
	fi

	emake -j1 MISCINCS="${miscincs}" || die "failed to build splashutils"

	cd ${SM}
	emake || die "failed to build miscsplashutils"
}

src_install() {
	cd ${S}
	make DESTDIR=${D} install || die

	keepdir /lib/splash/{tmp,cache,bin}

	cd ${SM}
	make DESTDIR=${D} install || die

	dosym /lib/splash/bin/fbres /sbin/fbres

	exeinto /sbin
	doexe ${SG}/splash

	exeinto /etc/init.d
	newexe ${SG}/init-splash splash

	insinto /sbin
	doins ${SG}/splash-functions.sh

	insinto /etc/conf.d
	newins ${SG}/splash.conf splash

	insinto /etc/splash
	doins ${SM}/fbtruetype/luxisri.ttf

	dodir /etc/splash/{emergence,gentoo}
	cp -pR ${WORKDIR}/{emergence,gentoo} ${D}/etc/splash
	ln -s emergence ${D}/etc/splash/default
	dodoc docs/* README AUTHORS

	if [ ! -e ${ROOT}/etc/splash/default ]; then
		dosym /etc/splash/emergence /etc/splash/default
	fi
}

pkg_postinst() {
	ewarn "Due to a change in the splash protocol you will have to rebuild"
	ewarn "all initrds created with previous versions of splashutils. This"
	ewarn "can be done with the splash_geninitramsfs script."
	echo ""
	einfo "For best effects, this new version of splashutils requires some"
	einfo "slight modifications to the kernel command line arguments in"
	einfo "GRUB/LILO/whatever bootloader you use."
	echo ""
	einfo "It is required that you add 'CONSOLE=/dev/tty1', to make sure all"
	einfo "init messages are printed to the first tty, and not the foreground one."
	einfo "It is advised that you add 'quiet' as an additional, standalone"
	einfo "parameter to suppress non-critical kernel messages."
	echo ""
	einfo "After these modifications, the relevant part of the kernel command"
	einfo "line might look like:"
	einfo "    splash=silent,fadein,tty:8,theme:emergence quiet CONSOLE=/dev/tty1"
	echo ""
	einfo "'tty:x' is used to specify the silent tty number. Use it to adjust"
	einfo "the silent splash so that there are no conflicts with services such"
	einfo "as consolefont."
}
