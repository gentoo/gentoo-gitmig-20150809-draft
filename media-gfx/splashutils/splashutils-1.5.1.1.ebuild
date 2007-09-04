# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splashutils/splashutils-1.5.1.1.ebuild,v 1.1 2007/09/04 07:12:27 spock Exp $

inherit eutils multilib toolchain-funcs

MISCSPLASH="miscsplashutils-0.1.8"
GENTOOSPLASH="splashutils-gentoo-1.0.7"
V_JPEG="6b"
V_PNG="1.2.18"
V_ZLIB="1.2.3"
V_FT="2.3.5"

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
KEYWORDS="~amd64 ~ppc ~x86"
RDEPEND="truetype? ( >=media-libs/freetype-2 )
	png? ( >=media-libs/libpng-1.2.7 )
	mng? ( media-libs/lcms media-libs/libmng )
	>=media-libs/jpeg-6b
	>=sys-apps/baselayout-1.9.4-r5
	app-arch/cpio
	media-gfx/fbgrab"
DEPEND="${RDEPEND}
	>=dev-libs/klibc-1.5"

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

	[ ! -d ${S}/libs ] && mkdir ${S}/libs
	[ ! -d ${S}/objs ] && mkdir ${S}/objs
	mv ${WORKDIR}/{libpng-${V_PNG},jpeg-${V_JPEG},zlib-${V_ZLIB},freetype-${V_FT}} ${S}/libs
	# We need to delete the Makefile and let it be rebuilt when splashutils
	# is being configured. Either that, or we end up with a segfaulting kernel
	# helper.
	rm ${S}/libs/zlib-${V_ZLIB}/Makefile

	cd ${S}
	ln -sf ${S} ${WORKDIR}/core

	# Check whether the kernel tree has been patched with fbcondecor.
	if [[ ! -e /usr/$(get_libdir)/klibc/include/linux/console_splash.h && \
		  ! -e /usr/$(get_libdir)/klibc/include/linux/console_decor.h ]]; then
		ewarn "The kernel tree against which dev-libs/klibc was built was not patched"
		ewarn "with a compatible version of fbcondecor. Splashutils will be compiled"
		ewarn "without fbcondecor support (i.e. verbose mode will not work)."
	fi

	if has_version sys-libs/glibc && ! built_with_use --missing true sys-libs/glibc nptl ; then
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

	if ! use truetype ; then
		sed -i -e 's/fbtruetype kbd/kbd/' ${SM}/Makefile
	fi

	sed -i -e "s#/lib/splash#/$(get_libdir)/splash#" ${S}/scripts/{splash_manager,splash_geninitramfs}
}

src_compile() {
	local myconf=""
	if [[ ! -e /usr/$(get_libdir)/klibc/include/linux/console_splash.h && \
		  ! -e /usr/$(get_libdir)/klibc/include/linux/console_decor.h ]]; then
		myconf="--without-fbcondecor"
	else
		myconf="--with-fbcondecor"
	fi

	cd ${SM}
	emake LIB=$(get_libdir) STRIP=true || die "failed to build miscsplashutils"

	cd ${S}
	./configure \
		--with-libdir="/$(get_libdir)" \
		$(use_with png) \
		$(use_with mng) \
		$(use_with gpm) \
		$(use_with truetype ttf) \
		$(use_with truetype ttfkern) \
		${myconf} || die "failed to configure splashutils"

	export ZLIBSRC LPNGSRC JPEGSRC FT2SRC
	emake -j1 || die "failed to build splashutils"

	if has_version ">=sys-apps/baselayout-1.13.99"; then
		cd ${SG}
		emake LIB=$(get_libdir) || die "failed to build the splash plugin"
	fi
}

src_install() {
	local LIB=$(get_libdir)

	cd ${SM}
	make DESTDIR=${D} LIB=${LIB} install || die

	export ZLIBSRC LPNGSRC JPEGSRC FT2SRC
	cd ${S}
	make DESTDIR=${D} LIB=${LIB} install || die

	mv ${D}/usr/${LIB}/libfbsplash.so* ${D}/${LIB}/
	gen_usr_ldscript libfbsplash.so

	echo 'CONFIG_PROTECT_MASK="/etc/splash"' > 99splash
	doenvd 99splash

	newinitd ${SG}/init-fbcondecor fbcondecor
	newconfd ${SG}/splash.conf splash
	newconfd ${SG}/fbcondecor.conf fbcondecor

	insinto /usr/share/${PN}
	doins ${SG}/initrd.splash

	insinto /etc/splash
	doins ${SM}/fbtruetype/luxisri.ttf

	dodoc docs/* README AUTHORS

	if has_version ">=sys-apps/baselayout-1.13.99"; then
		cd ${SG}
		make DESTDIR=${D} LIB=${LIB} install || die "failed to install the splash plugin"
	else
		cp ${SG}/splash-functions-bl1.sh ${D}/sbin/splash-functions.sh
	fi

	sed -i -e "s#/lib/splash#/${LIB}/splash#" ${D}/sbin/splash-functions.sh
	keepdir /${LIB}/splash/{tmp,cache,bin}
	dosym /${LIB}/splash/bin/fbres /sbin/fbres
}

pkg_postinst() {
	if has_version sys-fs/devfsd || ! has_version sys-fs/udev ; then
		elog "This package has been designed with udev in mind. Other solutions, such as"
		elog "devfs or a static /dev tree might work, but are generally discouraged and"
		elog "not supported. If you decide to switch to udev, you might want to have a"
		elog "look at 'The Gentoo udev Guide', which can be found at"
		elog "  http://www.gentoo.org/doc/en/udev-guide.xml"
		elog ""
	fi

	if has_version '<media-gfx/splashutils-1.0' ; then
		elog "Since you are upgrading from a pre-1.0 version, please make sure that you"
		elog "rebuild your initrds. You can use the splash_geninitramfs script to do that."
		elog ""
	fi

	if ! test -f /proc/cmdline ||
		! egrep -q '(console|CONSOLE)=(tty1|/dev/tty1)' /proc/cmdline ; then
		elog "It is required that you add 'console=tty1' to your kernel"
		elog "command line parameters."
		elog ""
		elog "After these modifications, the relevant part of the kernel command"
		elog "line might look like:"
		elog "  splash=silent,fadein,theme:emergence console=tty1"
		elog ""
	fi

	if ! has_version 'media-gfx/splash-themes-livecd' &&
		! has_version 'media-gfx/splash-themes-gentoo'; then
		elog "The sample Gentoo themes (emergence, gentoo) have been removed from the"
		elog "core splashutils package. To get some themes you might want to emerge:"
		elog "  media-gfx/splash-themes-livecd"
		elog "  media-gfx/splash-themes-gentoo"
	fi

	elog "Please note that the 'fbsplash' kernel patch has now been renamed to"
	elog "'fbcondecor'.  Accordingly, the old 'splash' initscript is now called"
	elog "'fbcondecor'.  Make sure you update your system.  See:"
	elog "    http://dev.gentoo.org/~spock/projects/fbcondecor/#history"
	elog "for further info about the name changes."
	elog ""
	elog "Also note that splash_util has now been split into splash_util, fbsplashd"
	elog "and fbcondecor_ctl."
}
