# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-1.0.8-r5.ebuild,v 1.9 2004/03/31 07:53:03 leonardop Exp $

inherit libtool

IUSE="nls"

S=${WORKDIR}/GConf-${PV}
DESCRIPTION="Gconf"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/GConf/1.0/GConf-${PV}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc ~sparc alpha hppa amd64 ia64"

DEPEND="dev-util/indent
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	dev-libs/libxml
	dev-libs/popt
	gnome-base/oaf
	gnome-base/ORBit"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_unpack () {
	unpack ${A}
	epatch ${FILESDIR}/gconfd-2-fix.patch
}

src_compile() {
	local myconf

	elibtoolize

	use nls	\
		|| myconf="--disable-nls"	\
		&& mkdir intl			\
		&& touch intl/libgettext.h

	./configure --host=${CHOST}	\
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib \
		    ${myconf} || die

	make || die   # Doesn't work with -j 4 (hallski)
}

src_install() {

	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib \
	     install || die
	# gconf 1.0.8 seems to gets the perms wrong on this dir.
	chmod 0755 ${D}/etc/gconf/gconf.xml.mandatory
	# keep this mandatory dir
	touch ${D}/etc/gconf/gconf.xml.mandatory/.keep${SLOT}
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
