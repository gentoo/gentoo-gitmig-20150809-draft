# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gdm/gdm-2.6.0.9-r3.ebuild,v 1.4 2005/08/09 07:29:12 corsair Exp $

inherit gnome2 eutils pam

DESCRIPTION="GNOME2 Display Manager"
HOMEPAGE="http://www.jirka.org/gdm.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ppc64 sparc x86"
IUSE="tcpd xinerama selinux ipv6 pam"

SRC_URI="${SRC_URI}
	mirror://gentoo/gentoo-gdm-theme-r2.tar.bz2"
MY_V="${PV%.*}-openpam"

RDEPEND="pam? ( virtual/pam )
	!pam? ( sys-apps/shadow )
	>=x11-libs/pango-1.4.1
	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2
	>=gnome-base/librsvg-2
	>=media-libs/libart_lgpl-2.3.11
	>=dev-libs/libxml2-2.4.12
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomecanvas-2
	selinux? ( sys-libs/libselinux )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.11
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

G2CONF="${G2CONF} \
	--sysconfdir=/etc/X11 \
	--localstatedir=/var \
	--with-pam-prefix=/etc \
	--with-xdmcp \
	`use_enable ipv6` \
	`use_with tcpd tcp-wrappers` \
	`use_with xinerama` \
	`use_with selinux`"

use pam && G2CONF="${G2CONF} --with-pam-prefix=/etc --enable-authentication=pam" \
	|| G2CONF="${G2CONF} --enable-console-helper=no --enable-authentication-scheme=shadow"

src_unpack() {

	unpack ${A}

	cd ${S}
	# remove unneeded linker directive for selinux (#41022)
	epatch ${FILESDIR}/${PN}-2.4.4-selinux_remove_attr.patch
	# fix ipv6 config
	epatch ${FILESDIR}/${P}-ipv6_config.patch

	autoconf || die

}

src_install() {

	local pam_prefix

	use pam && pam_prefix="PAM_PREFIX=${D}/etc"

	gnome2_src_install \
		${pam_prefix} \
		sysconfdir=${D}/etc/X11 \
		localstatedir=${D}/var

	# gdm-binary should be gdm to work with our init (#5598)
	rm -f ${D}/usr/bin/gdm
	mv ${D}/usr/bin/gdm-binary ${D}/usr/bin/gdm
	dosym /usr/bin/gdm /usr/bin/gdm-binary

	# log, etc.
	keepdir /var/log/gdm
	keepdir /var/gdm
	chown root:gdm ${D}/var/gdm
	chmod 1770 ${D}/var/gdm

	# use our own session script
	rm -f ${D}/etc/X11/gdm/Xsession
	exeinto /etc/X11/gdm
	doexe ${FILESDIR}/${MY_V}/Xsession

	# add a custom xsession .desktop by default (#44537)
	exeinto /etc/X11/dm/Sessions
	doexe ${FILESDIR}/${MY_V}/custom.desktop

	# We replace the pam stuff by our own
	rm -f ${D}/etc/pam.d/gdm

	dopamd ${FILESDIR}/${MY_V}/pam.d/*
	dopamsecurity console.apps ${FILESDIR}/${MY_V}/security/console.apps/gdmconfig

	# use graphical greeter local
	dosed "s:#Greeter=/usr/bin/gdmlogin:Greeter=/usr/bin/gdmgreeter:" /etc/X11/gdm/gdm.conf

	# Move Gentoo theme in
	mv ${WORKDIR}/gentoo-*  ${D}/usr/share/gdm/themes

	dodoc AUTHORS ChangeLog INSTALL NEWS README* TODO

}

pkg_postinst() {

	gnome2_pkg_postinst

	# Soft restart, assumes Gentoo defaults for file locations
	FIFOFILE=/var/gdm/.gdmfifo
	PIDFILE=/var/run/gdm.pid
	if [ -w ${FIFOFILE} ] ; then
		if [ -f ${PIDFILE} ] ; then
			if kill -0 `cat ${PIDFILE}`; then
				(echo;echo SOFT_RESTART) >> ${FIFOFILE}
			fi
		fi
	fi

	einfo "To make GDM start at boot, edit /etc/rc.conf"
	einfo "and then execute 'rc-update add xdm default'."

}

pkg_postrm() {

	gnome2_pkg_postrm

	einfo "To remove GDM from startup please execute"
	einfo "'rc-update del xdm default'"

}
