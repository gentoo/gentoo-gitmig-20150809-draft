# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-1.0.9.ebuild,v 1.24 2006/09/05 01:58:52 kumba Exp $

inherit libtool gnome.org eutils gnuconfig

MY_PN=GConf
MY_P=${MY_PN}-${PV}
PVP=(${PV//[-\._]/ })

S=${WORKDIR}/${MY_P}

DESCRIPTION="Gnome Configuration System and Daemon"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="nls"

DEPEND="dev-util/indent
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	dev-libs/libxml
	dev-libs/popt
	gnome-base/oaf
	=gnome-base/orbit-0*
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/gconfd-2-fix.patch
	epatch ${FILESDIR}/${P}-locallock_mdk.patch
	epatch ${FILESDIR}/${P}-gcc4.patch
	epatch ${FILESDIR}/${P}-linguas.patch

	mkdir ${S}/intl
	touch ${S}/intl/libgettext.h

	elibtoolize
	gnuconfig_update
}

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	# gconf 1.0.8 seems to gets the perms wrong on this dir.
	chmod 0755 ${D}/etc/gconf/gconf.xml.mandatory
	# keep this mandatory dir
	keepdir /etc/gconf/gconf.xml.mandatory/.keep${SLOT}
	# this fix closes bug #803
	dodoc AUTHORS ChangeLog NEWS README* TODO
}

pkg_postinst() {
	# this is to fix installations where the following dir
	# has already been merged with incorrect permissions.
	# We can remove this fix after gconf 1.0.8 is an ancient
	# version.
	if [ ! -e ${ROOT}/etc/gconf/gconf.xml.mandatory ]
	then
		#unmerge of older revisions nuke this one
		mkdir -p ${ROOT}/etc/gconf/gconf.xml.mandatory
	fi
	chmod 0755 ${ROOT}/etc/gconf/gconf.xml.mandatory
}
