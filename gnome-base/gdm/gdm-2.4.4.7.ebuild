# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gdm/gdm-2.4.4.7.ebuild,v 1.2 2004/02/17 23:21:06 foser Exp $

inherit gnome2 eutils

DESCRIPTION="GNOME2 Display Manager"
HOMEPAGE="http://www.jirka.org/gdm.html"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE="tcpd xinerama selinux"
SRC_URI="${SRC_URI}
	mirror://gentoo/gentoo-gdm-theme-r1.tar.bz2"
MY_V="`echo ${PV} |cut -b -5`"

RDEPEND=">=sys-libs/pam-0.72
	>=x11-libs/gtk+-2
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
	--with-pam-prefix=/etc \
	--with-xdmcp \
	`use_with tcpd tcp-wrappers` \
	`use_with xinerama` \
	`use_enable selinux`"

src_unpack() {

	unpack ${A}

	cd ${S}
	# remove unneeded linker directive for selinux (#41022)
	epatch ${FILESDIR}/${PN}-${MY_V}-selinux_remove_attr.patch

}

src_install() {

	gnome2_src_install PAM_PREFIX=${D}/etc sysconfdir=${D}/etc/X11

	# gdm-binary should be gdm to work with our init (#5598)
	rm -f ${D}/usr/bin/gdm
	mv ${D}/usr/bin/gdm-binary ${D}/usr/bin/gdm
	dosym /usr/bin/gdm /usr/bin/gdm-binary

	# log, etc.
	dodir /var/lib/gdm
	chown gdm:gdm ${D}/var/lib/gdm
	chmod 750 ${D}/var/lib/gdm

	# use our own session script
	rm -f ${D}/etc/X11/gdm/Xsession
	exeinto /etc/X11/gdm
	doexe ${FILESDIR}/${MY_V}/Xsession

	# We replace the pam stuff by our own
	rm -f ${D}/etc/pam.d/gdm

	# pam startup
	dodir /etc/pam.d
	insinto /etc/pam.d
	doins ${FILESDIR}/${MY_V}/pam.d/gdm
	doins ${FILESDIR}/${MY_V}/pam.d/gdmconfig
	doins ${FILESDIR}/${MY_V}/pam.d/gdm-autologin

	# pam security
	dodir /etc/security/console.apps
	insinto /etc/security/console.apps
	doins ${FILESDIR}/${MY_V}/security/console.apps/gdmconfig

	# use graphical greeter local
	dosed "s:#Greeter=/usr/bin/gdmlogin:Greeter=/usr/bin/gdmgreeter:" /etc/X11/gdm/gdm.conf
	# use Gentoo theme
	dosed "s:#GraphicalTheme=circles:GraphicalTheme=gentoo-cow:" /etc/X11/gdm/gdm.conf

	# Move Gentoo theme in
	mv ${WORKDIR}/gentoo-cow  ${D}/usr/share/gdm/themes

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README* TODO

}

pkg_postinst() {

	gnome2_pkg_postinst

	# Soft restart, assumes Gentoo defaults for file locations
	FIFOFILE=/var/lib/gdm/.gdminfo
	PIDFILE=/var/run/gdm.pid
	if [ -w ${FIFOFILE} ] ; then
		if [ -f ${PIDFILE} ] ; then
			if [ kill -0 `cat ${PIDFILE}` ] ; then
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
