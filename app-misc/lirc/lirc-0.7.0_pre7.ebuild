# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lirc/lirc-0.7.0_pre7.ebuild,v 1.1 2004/08/01 22:07:51 lanius Exp $

inherit eutils kmod

DESCRIPTION="LIRC is a package that allows you to decode and send infra-red \
	signals of many (but not all) commonly used remote controls."
HOMEPAGE="http://www.lirc.org"

# LIRC_OPTS = ???? v
# This are the defaults. With this support for all supported remotes
# will be build.
# If you want other options then set the Environment variable to your needs.

# Note: If you don't specify the driver configure becomes interactiv.

# You have to know, which driver you want;
# --with-driver=X

# where X is one of:
# none, any, animax, avermedia, avermedia98,
# bestbuy, bestbuy2, caraca, chronos, comX,
# cph03x, cph06x, creative, fly98, flyvideo,
# hauppauge,hauppauge_dvb, ipaq, irdeo,
# irdeo_remote, irman, irreal, it87, knc_one,
# logitech, lptX, mediafocusI, packard_bell,
# parallel, pctv, pixelview_bt878,
# pixelview_pak, pixelview_pro, provideo,
# realmagic, remotemaster, serial, silitek,
# sir, slinke, tekram, winfast_tv2000

# This could be usefull too

# --with-port=port	# port number for the lirc device.
# --with-irq=irq	# irq line for the lirc device.
# --with-timer=value	# timer value for the parallel driver
# --with-tty=file	# tty to use (Irman, RemoteMaster, etc.)
# --without-soft-carrier	# if your serial hw generates carrier
# --with-transmitter	# if you use a transmitter diode

SLOT="0"
LICENSE="GPL-2"
IUSE="doc"
KEYWORDS="~x86 ~ppc ~alpha ~ia64 ~amd64 ~ppc64"

DEPEND="virtual/linux-sources"

MY_P=${P/_/}

SRC_URI="http://lirc.sourceforge.net/software/snapshots/${MY_P}.tar.bz2
	http://www.hardeman.nu/~david/lirc/broken-out/01-add-2.6-devfs-and-sysfs-to-lirc_dev.patch"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/01-add-2.6-devfs-and-sysfs-to-lirc_dev.patch
	sed	-i -e "s:-O2 -g:${CFLAGS}:" configure configure.in
}

src_compile() {
	[ "x${LIRC_OPTS}" = x ] && LIRC_OPTS="--with-driver=serial \
		--with-port=0x3f8 --with-irq=4"

	if is_kernel 2 6; then
		kmod_make_linux_writable
	fi

	# remove parallel driver on SMP systems
	if [ ! -z "`uname -v | grep SMP`" ]
	then
		sed -i -e "s:lirc_parallel::" drivers/Makefile
	fi

	unset ARCH
	econf \
		--disable-manage-devices \
		--with-syslog=LOG_DAEMON \
		--enable-sandboxed \
		${LIRC_OPTS} || die "./configure failed"

	emake || die

}

src_install() {
	make DESTDIR=${D} install || die

	exeinto /etc/init.d
	doexe ${FILESDIR}/lircd

	insinto /etc/conf.d
	newins ${FILESDIR}/lircd.conf lircd

	if [ "${PROFILE_ARCH}" == "xbox" ]; then
		insinto /etc
		newins ${FILESDIR}/xbox-lircd.conf lircd.conf
	fi

	if [ `use doc` ]; then
		dohtml doc/html/*.html
		insinto /usr/share/doc/${PF}/images
		doins doc/images/*
	fi
}

pkg_postinst() {
	/usr/sbin/update-modules

	einfo
	einfo "The lirc Linux Infrared Remote Control Package has been"
	einfo "merged, please read the documentation, and if necessary"
	einfo "add what is needed to /etc/modules.autoload or"
	einfo "/etc/modules.d.  If you need special compile options"
	einfo "then read the comments at the begin of this"
	einfo "ebuild (source) and set the LIRC_OPTS environment"
	einfo "variable to your needs."
	einfo
}
