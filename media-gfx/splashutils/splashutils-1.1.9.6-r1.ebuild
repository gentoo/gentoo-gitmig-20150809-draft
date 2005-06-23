# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splashutils/splashutils-1.1.9.6-r1.ebuild,v 1.2 2005/06/23 14:46:39 spock Exp $

inherit multilib linux-mod

MISCSPLASH="miscsplashutils-0.1.3"
GENTOOSPLASH="splashutils-gentoo-0.1.10"
V_KLIBC="1.0.8"
V_JPEG="6b"
V_PNG="1.2.8"
V_ZLIB="1.2.1"
V_FT="2.1.9"

IUSE="hardened png truetype kdgraphics"

DESCRIPTION="Framebuffer splash utilities."
HOMEPAGE="http://dev.gentoo.org/~spock/projects/gensplash/"
SRC_URI="mirror://gentoo/${PN}-lite-${PV}.tar.bz2
	 mirror://gentoo/${GENTOOSPLASH}.tar.bz2
	 mirror://gentoo/${MISCSPLASH}.tar.bz2
	 mirror://sourceforge/libpng/libpng-${V_PNG}.tar.bz2
	 ftp://ftp.uu.net/graphics/jpeg/jpegsrc.v${V_JPEG}.tar.gz
	 mirror://sourceforge/freetype/freetype-${V_FT}.tar.bz2
	 http://www.gzip.org/zlib/zlib-${V_ZLIB}.tar.bz2
	 ftp://ftp.kernel.org/pub/linux/libs/klibc/klibc-${V_KLIBC}.tar.bz2
	 ftp://ftp.kernel.org/pub/linux/libs/klibc/Stable/klibc-${V_KLIBC}.tar.bz2
	 ftp://ftp.kernel.org/pub/linux/libs/klibc/Testing/klibc-${V_KLIBC}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
RDEPEND="truetype? ( >=media-libs/freetype-2 )
	png? ( >=media-libs/libpng-1.2.7 )
	>=media-libs/jpeg-6b
	>=sys-apps/baselayout-1.9.4-r5
	!media-gfx/bootsplash
	media-gfx/fbgrab"
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

spl_conf() {
	sed -i -re "s/#.* $2([^_].*|$)//g" ${S}/config.h

	if [[ "$1" == "yes" ]]; then
		echo "#define	$2 1" >> ${S}/config.h
	else
		echo "#undef	$2" >> ${S}/config.h
	fi
}

spl_conf_use() {
	if use $1; then
		spl_conf yes $2
	else
		spl_conf no $2
	fi
}

src_unpack() {
	unpack ${A}
	ln -s /usr/src/linux ${S}/linux

	mv ${WORKDIR}/{libpng-${V_PNG},jpeg-${V_JPEG},zlib-${V_ZLIB},freetype-${V_FT},klibc-${V_KLIBC}} ${S}/libs
	ln -s ../../linux ${S}/libs/klibc-${V_KLIBC}/linux
	# We need to delete the Makefile and let it be rebuilt when splashutils
	# is being configured. Either that, or we end up with a segfaulting kernel
	# helper.
	rm ${S}/libs/zlib-${V_ZLIB}/Makefile

	check_kernel_built

	# Check whether the kernel tree has been patched with fbsplash.
	if [[ ! -e ${KV_DIR}/include/linux/console_splash.h ]]; then
		ewarn "Your kernel in ${KV_DIR} has not been patched with a compatible version"
		ewarn "of fbsplash. You can download the latest patch from http://dev.gentoo.org/~spock/"
		echo ""
		ewarn "Splashutils will be compiled without fbsplash support. Verbose mode will not"
		ewarn "be supported."
		spl_conf no CONFIG_FBSPLASH
	else
		spl_conf yes CONFIG_FBSPLASH
	fi

	# This should make splashutils compile on systems with hardened GCC.
	sed -e 's@K_CFLAGS =@K_CFLAGS = -fno-stack-protector@' -i ${S}/Makefile
	sed -e 's@CFLAGS  =@CFLAGS  = -fno-stack-protector@' -i ${S}/libs/klibc-${V_KLIBC}/klibc/MCONFIG

	mkdir ${S}/kernel

	# Use tty16 as the default silent tty.
	sed -i -e 's/#define TTY_SILENT.*/#define TTY_SILENT 16/' ${S}/splash.h

	sed -i -e 's#/usr/bin/openvt -fc ${TTY}#/usr/bin/openvt -c ${TTY} echo -n ""#' ${SG}/init-splash
}

src_compile() {
	local miscincs

	if [ -n "${KBUILD_OUTPUT}" ]; then
		miscincs="-I${T} -I${KBUILD_OUTPUT}/include"
	fi

	spl_conf_use png CONFIG_PNG
	spl_conf_use truetype CONFIG_TTF
	spl_conf_use truetype CONFIG_TTF_KERNEL
	spl_conf_use kdgraphics CONFIG_SILENT_KD_GRAPHICS
	sed -i -e "s/^CFLAGS[ \t]*=.*/CFLAGS = ${CFLAGS}/" Makefile
	emake -j1 MISCINCS="${miscincs}" || die "failed to build splashutils"

	cd ${SM}
	emake LIB=$(get_libdir) || die "failed to build miscsplashutils"
}

src_install() {
	cd ${SM}
	make DESTDIR=${D} install || die

	cd ${S}
	make DESTDIR=${D} install || die

	keepdir /lib/splash/{tmp,cache,bin}
	dosym /lib/splash/bin/fbres /sbin/fbres

	dodir /etc/env.d
	echo 'CONFIG_PROTECT_MASK="/etc/splash"' > ${D}/etc/env.d/99splash

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

	dodoc docs/* README AUTHORS
}

pkg_postinst() {
	ebegin "Checking whether /dev/tty1 is in place"
	mount --bind / ${T}
	if [[ ! -c ${T}/dev/tty1 ]]; then
		eend 1
		ewarn "It appears that the /dev/tty1 character device doesn't exist on"
		ewarn "the root filesystem. This will prevent the silent mode from working"
		ewarn "properly. You can fix the problem by doing:"
		ewarn "  mount --bind / /lib/splash/tmp"
		ewarn "  mknod /lib/splash/tmp/dev/tty1 c 4 1"
		ewarn "  umount /lib/splash/tmp"
	else
		eend 0
	fi
	umount ${T}

	echo ""
	ewarn "Due to a change in the splash protocol you will have to rebuild"
	ewarn "all initrds created with splashutils < 1.1.9. This can be done"
	ewarn "with the splash_geninitramsfs script."
	echo ""
	ewarn "It is required that you add 'CONSOLE=/dev/tty1', to make sure all"
	ewarn "init messages are printed to the first tty, and not the foreground one."
	ewarn "It is advised that you add 'quiet' as an additional, standalone"
	ewarn "parameter to suppress non-critical kernel messages."
	echo ""
	einfo "After these modifications, the relevant part of the kernel command"
	einfo "line might look like:"
	einfo "    splash=silent,fadein,theme:emergence quiet CONSOLE=/dev/tty1"
	echo ""
	einfo "The sample Gentoo themes (emergence, gentoo) have been removed from the"
	einfo "core splashutils package. To get some themes you might want to emerge:"
	einfo "    media-gfx/splash-themes-livecd"
	einfo "    media-gfx/splash-themes-gentoo"
	echo ""
}
