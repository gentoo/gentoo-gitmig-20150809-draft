# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lirc/lirc-0.7.0-r1.ebuild,v 1.2 2004/12/09 13:03:47 lanius Exp $

inherit eutils linux-mod

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
# sir, slinke, streamzap tekram, winfast_tv2000

# This could be usefull too

# --with-port=port	# port number for the lirc device.
# --with-irq=irq	# irq line for the lirc device.
# --with-timer=value	# timer value for the parallel driver
# --with-tty=file	# tty to use (Irman, RemoteMaster, etc.)
# --without-soft-carrier	# if your serial hw generates carrier
# --with-transmitter	# if you use a transmitter diode

SLOT="0"
LICENSE="GPL-2"
IUSE="debug doc streamzap"
KEYWORDS="~x86 ~ppc ~alpha ~ia64 ~amd64 ~ppc64"

RDEPEND="virtual/libc
	X11? ( virtual/x11 )"
	
DEPEND="virtual/linux-sources
	sys-devel/autoconf
	${RDEPEND}"

SRC_URI="mirror://sourceforge/lirc/${P}.tar.bz2"

src_unpack() {
	unpack ${A}
	cd ${S}
	use streamzap && epatch ${FILESDIR}/lirc-0.7.0-streamzap.patch.bz2
	if [ "${PROFILE_ARCH}" == "xbox" ]; then
		epatch ${FILESDIR}/lirc-0.7.0-xbox.patch.bz2
	fi
	sed	-i -e "s:-O2 -g:${CFLAGS}:" configure configure.in
}

src_compile() {
	# set default configure options
	[ "x${LIRC_OPTS}" = x ] && [ "${PROFILE_ARCH}" == "xbox" ] && \
		LIRC_OPTS="--with-driver=xboxusb"
	[ "x${LIRC_OPTS}" = x ] && LIRC_OPTS="--with-driver=serial \
		--with-port=0x3f8 --with-irq=4"

	# remove parallel driver on SMP systems
	if [ ! -z "`uname -v | grep SMP`" ]; then
		sed -i -e "s:lirc_parallel::" drivers/Makefile
	fi

	# Patch bad configure for /usr/src/linux
	sed -si "s|/usr/src/kernel\-source\-\`uname \-r\` /usr/src/linux\-\`uname \-r\` ||" \
		acinclude.m4 aclocal.m4 configure || die "/usr/src/linux sed failed"

	get_version
	sed -si "s|\`uname \-r\`|${KV_FULL}|" configure configure.in setup.sh || \
		die "/lib/modules sed failed"

	unset ARCH
	export WANT_AUTOCONF=2.5

	econf \
		--disable-manage-devices \
		--localstatedir=/var \
		--with-syslog=LOG_DAEMON \
		--enable-sandboxed \
		`use_enable debug` \
		${LIRC_OPTS} || die "./configure failed"

	convert_to_m ${S}/Makefile
	emake || die

}

src_install() {
	make DESTDIR=${D} install || die

	exeinto /etc/init.d
	doexe ${FILESDIR}/lircd
	doexe ${FILESDIR}/lircmd

	insinto /etc/conf.d
	newins ${FILESDIR}/lircd.conf lircd

	if use doc ; then
		dohtml doc/html/*.html
		insinto /usr/share/doc/${PF}/images
		doins doc/images/*
	fi
}

pkg_postinst() {
	einfo
	einfo "The lirc Linux Infrared Remote Control Package has been"
	einfo "merged, please read the documentation, and if necessary"
	einfo "add what is needed to /etc/modules.autoload or"
	einfo "/etc/modules.d.  If you need special compile options"
	einfo "then read the comments at the begin of this"
	einfo "ebuild (source) and set the LIRC_OPTS environment"
	einfo "variable to your needs."
	einfo

	update_depmod
}
