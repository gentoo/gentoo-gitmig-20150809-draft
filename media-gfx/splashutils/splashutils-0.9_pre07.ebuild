# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splashutils/splashutils-0.9_pre07.ebuild,v 1.7 2005/01/04 18:35:51 hansmi Exp $

MISCSPLASH="miscsplashutils-0.1.1"
GENTOOSPLASH="splashutils-gentoo-0.1"

DESCRIPTION="Framebuffer splash utilities."
HOMEPAGE="http://dev.gentoo.org/~spock/"
SRC_URI="mirror://gentoo/${P/_/-}.tar.bz2
	 mirror://gentoo/${MISCSPLASH}.tar.bz2
	 mirror://gentoo/${GENTOOSPLASH}.tar.bz2
	 mirror://gentoo/fbsplash-theme-emergence.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=media-libs/freetype-2
	media-libs/libpng
	media-libs/jpeg
	>=sys-apps/baselayout-1.10.4
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
		eerror "It appears that your kernel has not been configured. Please run at least"
		eerror "\`make prepare\` before merging splashutils."
		die "Kernel not configured"
	fi
}

src_compile() {
	emake -j1

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

	dodir /etc/splash/emergence
	cp -pR ${WORKDIR}/emergence ${D}/etc/splash
	ln -s emergence ${D}/etc/splash/default
	dodoc docs/* README AUTHORS

	# fix a little bug in the current version of the emergence theme.
	sed -re 's/silent-([0-9]+x[0-9]+)-240/silent-\1-256/g' -i ${D}/etc/splash/emergence/*.cfg

	if [ ! -e ${ROOT}/etc/splash/default ]; then
		dosym /etc/splash/emergence /etc/splash/default
	fi
}
