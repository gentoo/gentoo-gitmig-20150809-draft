# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splashutils/splashutils-0.9_rc1.ebuild,v 1.1 2004/11/12 21:33:31 spock Exp $

MISCSPLASH="miscsplashutils-0.1.2"
GENTOOSPLASH="splashutils-gentoo-0.1.3"

DESCRIPTION="Framebuffer splash utilities."
HOMEPAGE="http://dev.gentoo.org/~spock/"
SRC_URI="mirror://gentoo/${P/_/-}.tar.bz2
	 mirror://gentoo/${MISCSPLASH}.tar.bz2
	 mirror://gentoo/${GENTOOSPLASH}.tar.bz2
	 mirror://gentoo/fbsplash-theme-emergence-r2.tar.bz2
	 mirror://gentoo/fbsplash-theme-gentoo-r1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=">=media-libs/freetype-2
	media-libs/libpng
	media-libs/jpeg
	>=sys-apps/baselayout-1.9.4-r5
	!media-gfx/bootsplash"
DEPEND="${RDEPEND}
	virtual/linux-sources"

S="${WORKDIR}/${P/_/-}"
SM="${WORKDIR}/${MISCSPLASH}"
SG="${WORKDIR}/${GENTOOSPLASH}"

src_unpack() {
	unpack ${A}
	ln -s /usr/src/linux ${S}/linux
	if [ ! -e /usr/src/linux/include/linux/console_splash.h ]; then
		eerror "Your kernel in /usr/src/linux has not been patched with a compatible version"
		eerror "of fbsplash. Please download the latest patch from http://dev.gentoo.org/~spock/"
		eerror "and patch your kernel."
		die "Fbsplash not found"
	fi

	if [ ! -e /usr/src/linux/include/asm ]; then

		t=$(readlink /usr/src/linux)
		t=${t#/usr/src/}

		if [ -z "${KBUILD_OUTPUT_PREFIX}" ] ||
		   [ ! -e "${KBUILD_OUTPUT_PREFIX}/${t/linux-}/include/asm" ]; then
			eerror "It appears that your kernel has not been configured. Please run at least"
			eerror "\`make prepare\` before merging splashutils."
			die "Kernel not configured"
		else
			t2=$(readlink ${KBUILD_OUTPUT_PREFIX}/${t/linux-}/include/asm)
			ln -s /usr/src/linux/include/${t2} ${T}/asm
			sed -e "s@#CHANGEME#@${T}/@" -i ${S}/libs/klibc-0.179/klibc/makeerrlist.pl
		fi
	fi
}

src_compile() {

	local miscincs

	if [ -n "${KBUILD_OUTPUT_PREFIX}" ]; then
		t=$(readlink /usr/src/linux)
		t=${t#/usr/src/}
		miscincs="-I${T} -I${KBUILD_OUTPUT_PREFIX}/${t/linux-}/include"
	fi

	emake -j1 MISCINCS="${miscincs}"

	cd ${SM}
	emake
}

src_install() {
	cd ${SM}
	make DESTDIR=${D} install || die

	cd ${S}
	make DESTDIR=${D} install || die

	exeinto /sbin
	doexe ${SG}/splash

	exeinto /etc/init.d
	newexe ${SG}/init-splash splash

	insinto /sbin
	doins ${SG}/splash-functions.sh

	insinto /etc/conf.d
	newins ${SG}/splash.conf splash

	dodir /etc/splash/{emergence,gentoo}
	cp -pR ${WORKDIR}/{emergence,gentoo} ${D}/etc/splash
	ln -s emergence ${D}/etc/splash/default
	dodoc docs/* README AUTHORS

	if [ ! -e ${ROOT}/etc/splash/default ]; then
		dosym /etc/splash/emergence /etc/splash/default
	fi
}
