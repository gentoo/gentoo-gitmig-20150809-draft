# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-1.0.8-r1.ebuild,v 1.2 2002/02/25 00:50:27 drobbins Exp $

S=${WORKDIR}/GConf-${PV}
DESCRIPTION="Gconf"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/GConf/GConf-${PV}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
RDEPEND=">=sys-libs/db-3.2.3h >=gnome-base/oaf-0.6.6-r1"
DEPEND="${RDEPEND} nls? ( sys-devel/gettext ) >=dev-util/guile-1.4"

src_compile() {
	local myconf
	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi

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
	# this fix closes bug #803
	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}

pkg_postinst() {
	# this is to fix installations where the following dir
	# has already been merged with incorrect permissions.
	# We can remove this fix after gconf 1.0.8 is an ancient
	# version.
	chmod 0755 ${ROOT}/etc/gconf/gconf.xml.mandatory
}
