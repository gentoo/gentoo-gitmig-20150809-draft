# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splashutils/splashutils-1.3-r2.ebuild,v 1.1 2006/08/08 22:01:02 spock Exp $

inherit eutils multilib toolchain-funcs

MISCSPLASH="miscsplashutils-0.1.5"
GENTOOSPLASH="splashutils-gentoo-0.5.2"
V_JPEG="6b"
V_PNG="1.2.8"
V_ZLIB="1.2.3"
V_FT="2.1.9"

ZLIBSRC="libs/zlib-${V_ZLIB}"
LPNGSRC="libs/libpng-${V_PNG}"
JPEGSRC="libs/jpeg-${V_JPEG}"
FT2SRC="libs/freetype-${V_FT}"

IUSE="hardened png truetype mng"

DESCRIPTION="Framebuffer splash utilities."
HOMEPAGE="http://dev.gentoo.org/~spock/projects/gensplash/"
SRC_URI="mirror://gentoo/${PN}-lite-${PV}.tar.bz2
	mirror://gentoo/${GENTOOSPLASH}.tar.bz2
	mirror://gentoo/${MISCSPLASH}.tar.bz2
	mirror://sourceforge/libpng/libpng-${V_PNG}.tar.bz2
	ftp://ftp.uu.net/graphics/jpeg/jpegsrc.v${V_JPEG}.tar.gz
	mirror://sourceforge/freetype/freetype-${V_FT}.tar.bz2
	http://www.gzip.org/zlib/zlib-${V_ZLIB}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
RDEPEND="truetype? ( >=media-libs/freetype-2 )
	png? ( >=media-libs/libpng-1.2.7 )
	mng? ( media-libs/lcms media-libs/libmng )
	>=media-libs/jpeg-6b
	>=sys-apps/baselayout-1.9.4-r5
	app-arch/cpio
	!media-gfx/bootsplash
	media-gfx/fbgrab"
DEPEND="${RDEPEND}
	>=dev-libs/klibc-1.0.14-r1"

S="${WORKDIR}/${P/_/-}"
SG="${WORKDIR}/${GENTOOSPLASH}"
SM="${WORKDIR}/${MISCSPLASH}"

pkg_setup() {
	if use hardened; then
		ewarn "Due to problems with klibc, it is currently impossible to compile splashutils"
		ewarn "with 'hardened' GCC flags. As a workaround, the package will be compiled with"
		ewarn "-fno-stack-protector. Hardened GCC features will not be used while building"
		ewarn "the splash kernel helper."
	fi
}

src_unpack() {
	unpack ${A}

	mv ${WORKDIR}/{libpng-${V_PNG},jpeg-${V_JPEG},zlib-${V_ZLIB},freetype-${V_FT}} ${S}/libs
	# We need to delete the Makefile and let it be rebuilt when splashutils
	# is being configured. Either that, or we end up with a segfaulting kernel
	# helper.
	rm ${S}/libs/zlib-${V_ZLIB}/Makefile
	cd ${S}

	epatch ${FILESDIR}/splashutils-1.3-r2.patch

	# Check whether the kernel tree has been patched with fbsplash.
	if [[ ! -e ${ROOT}/usr/$(get_libdir)/klibc/include/linux/console_splash.h ]]; then
		ewarn "The kernel tree against which dev-libs/klibc was built was not patched"
		ewarn "with a compatible version of fbsplash. Splashutils will be compiled"
		ewarn "without fbsplash support (ie. verbose mode will not work)."
	fi

	if built_with_use sys-devel/gcc vanilla ; then
		ewarn "Your GCC was built with the 'vanilla' flag set. If you can't compile"
		ewarn "splashutils, you're on your own, as this configuration is not supported."
	else
		# This should make splashutils compile on systems with hardened GCC.
		sed -e 's@K_CFLAGS =@K_CFLAGS = -fno-stack-protector@' -i ${S}/Makefile
	fi

	# Use tty16 as the default silent tty.
	sed -i -e 's/#define TTY_SILENT.*/#define TTY_SILENT 16/' ${S}/splash.h

	if ! use truetype ; then
		sed -i -e 's/fbtruetype kbd/kbd/' ${SM}/Makefile
	fi

	# Fix path to klibc headers on multilib systems
	sed -i -e "s:/lib/klibc:/$(get_libdir)/klibc:" ${S}/Makefile
}

src_compile() {
	local myconf=""
	if [[ ! -e ${ROOT}/usr/$(get_libdir)/klibc/include/linux/console_splash.h ]]; then
		myconf="--without-fbsplash"
	else
		myconf="--with-fbsplash"
	fi

	sed -i -e "s/^CFLAGS[ \t]*=.*/CFLAGS = ${CFLAGS}/" Makefile
	cd ${SM}
	emake LIB=$(get_libdir) || die "failed to build miscsplashutils"
	cd ${S}

	./configure \
		$(use_with png) \
		$(use_with mng) \
		$(use_with truetype ttf) \
		$(use_with truetype ttfkern) \
		${myconf} || die "failed to configure splashutils"

	export ZLIBSRC LPNGSRC JPEGSRC FT2SRC
	emake -j1 LIB=$(get_libdir) ARCH=$(tc-arch-kernel) || die "failed to build splashutils"
}

src_install() {
	cd ${SM}
	make DESTDIR=${D} install || die

	export ZLIBSRC LPNGSRC JPEGSRC FT2SRC
	cd ${S}
	make DESTDIR=${D} install || die

	keepdir /lib/splash/{tmp,cache,bin}
	dosym /lib/splash/bin/fbres /sbin/fbres

	dodir /etc/env.d
	echo 'CONFIG_PROTECT_MASK="/etc/splash"' > ${D}/etc/env.d/99splash

	exeinto /etc/init.d
	newexe ${SG}/init-splash splash

	insinto /usr/share/${PN}
	doins ${SG}/initrd.splash

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
		echo ""
	else
		eend 0
	fi
	umount ${T}

	if has_version sys-fs/devfsd || ! has_version sys-fs/udev ; then
		ewarn "This package has been designed with udev in mind. Other solutions, such as"
		ewarn "devfs or a static /dev tree might work, but are generally discouraged and"
		ewarn "not supported. If you decide to switch to udev, you might want to have a"
		ewarn "look at 'The Gentoo udev Guide', which can be found at"
		ewarn "  http://www.gentoo.org/doc/en/udev-guide.xml"
		echo ""
	fi

	if has_version '<media-gfx/splashutils-1.0' ; then
		ewarn "Since you are upgrading from a pre-1.0 version, please make sure that you"
		ewarn "rebuild your initrds. You can use the splash_geninitramfs script to do that."
		echo ""
	fi

	if ! test -f /proc/cmdline ||
		! egrep -q '(console|CONSOLE)=(tty1|/dev/tty1)' /proc/cmdline ; then
		ewarn "It is required that you add 'console=tty1' to your kernel"
		ewarn "command line parameters."
		echo ""
		einfo "After these modifications, the relevant part of the kernel command"
		einfo "line might look like:"
		einfo "  splash=silent,fadein,theme:emergence console=tty1"
		echo ""
	fi

	if ! has_version 'media-gfx/splash-themes-livecd' &&
		! has_version 'media-gfx/splash-themes-gentoo'; then
		einfo "The sample Gentoo themes (emergence, gentoo) have been removed from the"
		einfo "core splashutils package. To get some themes you might want to emerge:"
		einfo "  media-gfx/splash-themes-livecd"
		einfo "  media-gfx/splash-themes-gentoo"
	fi
}
