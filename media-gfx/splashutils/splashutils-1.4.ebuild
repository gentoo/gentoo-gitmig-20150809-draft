# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splashutils/splashutils-1.4.ebuild,v 1.1 2007/04/05 22:14:00 spock Exp $

inherit eutils multilib toolchain-funcs

MISCSPLASH="miscsplashutils-0.1.5"
GENTOOSPLASH="splashutils-gentoo-1.0.0"
V_JPEG="6b"
V_PNG="1.2.8"
V_ZLIB="1.2.3"
V_FT="2.1.9"

ZLIBSRC="libs/zlib-${V_ZLIB}"
LPNGSRC="libs/libpng-${V_PNG}"
JPEGSRC="libs/jpeg-${V_JPEG}"
FT2SRC="libs/freetype-${V_FT}"

IUSE="hardened png truetype mng gpm"

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
	>=dev-libs/klibc-1.4.13"

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
	ln -sf ${S} ${WORKDIR}/core

	# Check whether the kernel tree has been patched with fbsplash.
	if [[ ! -e /usr/$(get_libdir)/klibc/include/linux/console_splash.h ]]; then
		ewarn "The kernel tree against which dev-libs/klibc was built was not patched"
		ewarn "with a compatible version of fbsplash. Splashutils will be compiled"
		ewarn "without fbsplash support (ie. verbose mode will not work)."
	fi

	if has_version sys-libs/glibc && ! built_with_use sys-libs/glibc nptl ; then
		eerror "Your sys-libs/glibc has been built with support for linuxthreads only."
		eerror "This package requires nptl to work correctly. Please recompile glibc"
		eerror "with the 'nptl' USE flag enabled."
		die "nptl not available"
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
}

src_compile() {
	local myconf=""
	if [[ ! -e /usr/$(get_libdir)/klibc/include/linux/console_splash.h ]]; then
		myconf="--without-fbsplash"
	else
		myconf="--with-fbsplash"
	fi

	if has_version ">=sys-apps/baselayout-1.13.99"; then
		myconf="${myconf} --with-gentoo"
	fi

	cd ${SM}
	emake LIB=$(get_libdir) || die "failed to build miscsplashutils"

	cd ${S}
	./configure \
		$(use_with png) \
		$(use_with mng) \
		$(use_with gpm) \
		$(use_with truetype ttf) \
		$(use_with truetype ttfkern) \
		${myconf} || die "failed to configure splashutils"

	export ZLIBSRC LPNGSRC JPEGSRC FT2SRC
	emake -j1 LIB=$(get_libdir) CFLAGS="${CFLAGS}" \
		|| die "failed to build splashutils"

	if has_version ">=sys-apps/baselayout-1.13.99"; then
		cd ${SG}
		emake || die "failed to build the splash plugin"
	fi
}

src_install() {
	cd ${SM}
	make DESTDIR=${D} install || die

	export ZLIBSRC LPNGSRC JPEGSRC FT2SRC
	cd ${S}
	make DESTDIR=${D} install || die

	dodir /etc/env.d
	echo 'CONFIG_PROTECT_MASK="/etc/splash"' > ${D}/etc/env.d/99splash

	exeinto /etc/init.d
	newexe ${SG}/init-splash splash

	insinto /usr/share/${PN}
	doins ${SG}/initrd.splash

	insinto /etc/conf.d
	newins ${SG}/splash.conf splash

	insinto /etc/splash
	doins ${SM}/fbtruetype/luxisri.ttf

	dodoc docs/* README AUTHORS

	if has_version ">=sys-apps/baselayout-1.13.99"; then
		LIB=$(get_libdir)
		cd ${SG}
		make DESTDIR=${D} install || die "failed to install the splash plugin"
	else
		LIB=lib
		cp ${SG}/splash-functions-bl1.sh ${D}/sbin/splash-functions.sh
	fi

	keepdir /${LIB}/splash/{tmp,cache,bin}
	dosym /${LIB}/splash/bin/fbres /sbin/fbres
}

pkg_postinst() {
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
