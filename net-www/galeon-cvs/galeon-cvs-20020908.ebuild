# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon-cvs/galeon-cvs-20020908.ebuild,v 1.7 2002/09/08 20:14:17 azarah Exp $


# ECVS_TOP_DIR="${PORTAGE_TMPDIR}"
ECVS_SERVER="anoncvs.gnome.org:/cvs/gnome"
ECVS_MODULE="galeon"
ECVS_CVS_OPTIONS="-dP"

inherit cvs
inherit gnome2
# inherit debug to enable debugging and do it after gnome2 so as not gnome2 notices debugging
inherit debug libtool

S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="Galeon is a Web Browser for the Gnome Desktop.  The web, only the web."
HOMEPAGE="http://www.galeon.org/"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="virtual/x11
	>=net-www/mozilla-1.1-r1
	>=gnome-base/gnome-2.0.0
	>=gnome-base/gnome-common-1.2.4
	dev-util/cvs"

RDEPEND="${DEPEND}"

pkg_setup () {
	if [ ! -f ${ROOT}/usr/lib/mozilla/components/libwidget_gtk2.so ]
	then
		eerror "you need mozilla-1.1-r1 or higher compiled against gtk+-2"
		eerror "export USE=\"gtk2\" ;emerge mozilla -p "
		die "Need Mozilla compiled with gtk+-2.0!!"
	fi
			
}


src_compile() {
	elibtoolize
	cd ${S}
	local myconf=" --with-mozilla-snapshot --disable-werror"
	local baseopts="--prefix=/usr\
				--mandir=/usr/share/man \
				--infodir=/usr/share/info \
				--datadir=/usr/share \
				--sysconfdir=/etc \
				--localstatedir=/var/lib"

	if [ ! -f ./configure ]; then
		./autogen.sh ${baseopts} ${myconf} || die "autogen failed"
	else
		./configure ${baseopts} ${myconf}  || die "configure failed"
	fi
	make || die "compile failed"
}

src_install () {
 	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	einstall scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/ || die "make install failed"
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	
	dodoc AUTHORS COPYING COPYING.README ChangeLog ChangeLog-1.0 FAQ INSTALL README README.ExtraPrefs THANKS TODO NEWS 
	einfo "${PORTAGE_TMPDIR}/galeon should be erased if existing"
	einfo "this was the old storage for galeon cvs tree, now standardized to another location"
}

