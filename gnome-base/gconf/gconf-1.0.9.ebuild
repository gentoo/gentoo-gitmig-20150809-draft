# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-1.0.9.ebuild,v 1.3 2004/02/06 11:10:13 liquidx Exp $

inherit libtool gnome.org

IUSE="nls"

MY_PN=GConf
MY_P=${MY_PN}-${PV}
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
S=${WORKDIR}/GConf-${PV}

S=${WORKDIR}/${MY_P}

DESCRIPTION="Gnome Configuration System and Daemon"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"

DEPEND="dev-util/indent
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	dev-libs/libxml
	dev-libs/popt
	gnome-base/oaf
	gnome-base/ORBit"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack () {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/gconfd-2-fix.patch
	epatch ${FILESDIR}/${P}-locallock_mdk.patch
	
	mkdir ${S}/intl
	touch ${S}/intl/libgettext.h	
}

src_compile() {
	elibtoolize
	econf $(use_enable nls)
	emake || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die "install failed"

	# gconf 1.0.8 seems to gets the perms wrong on this dir.
	chmod 0755 ${D}/etc/gconf/gconf.xml.mandatory
	# keep this mandatory dir
	keepdir /etc/gconf/gconf.xml.mandatory/.keep${SLOT}
	# this fix closes bug #803
	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO

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
