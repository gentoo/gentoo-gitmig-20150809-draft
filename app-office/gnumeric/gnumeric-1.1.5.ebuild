# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.1.5.ebuild,v 1.4 2002/07/29 06:08:32 spider Exp $

#provide Xmake and Xemake
inherit virtualx

S=${WORKDIR}/${P}
DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/gnome-office/gnumeric.shtml"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

#Eye Of Gnome (media-gfx/eog) is for image support.
RDEPEND="=x11-libs/gtk+-2.0*
	=dev-libs/glib-2.0*
	>=gnome-base/libgnome-1.105.0
	>=gnome-base/libgnomeui-1.106.0
	>=gnome-base/libbonobo-1.106.0
	>=gnome-base/libbonoboui-1.106.0
	>=gnome-base/libgnomeprint-1.106.0
	>=gnome-base/libgnomeprintui-1.106.0
	>=gnome-extra/gal2-0.0.3
	>=gnome-base/libglade-1.99.10
	dev-libs/libxml2
	perl?   ( >=sys-devel/perl-5.6 )
	python? ( >=dev-lang/python-2.0 )
	gb?     ( ~gnome-extra/gb-0.0.17 )
	libgda? ( >=gnome-extra/libgda-0.2.91
	          >=gnome-base/bonobo-1.0.17 )
	evo?    ( >=net-mail/evolution-0.13 )"

DEPEND="${RDEPEND}
	 nls? ( sys-devel/gettext
	 >=dev-util/intltool-0.11 )"


src_unpack() {
	unpack ${A}
	cd ${S}

	# fix the relink bug, and invalid paths in .ls files.
	libtoolize --copy --force
}

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	use gb && myconf="${myconf} --with-gb" || myconf="${myconf} --without-gb"

	use guile && myconf="${myconf} --with-guile" || myconf="${myconf} --without-guile"
	use perl && myconf="${myconf} --with-perl" || myconf="${myconf} --without-perl"
  	use python && yconf="${myconf} --with-python" || myconf="${myconf} --without-python"

  	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		${myconf} || die

	#'gnumeric --dump-func-defs' needs to write to ${HOME}/.gnome/, or
	#else the build fails.
	# addwrite "${HOME}/.gnome"

	#the build process have to be able to connect to X
	Xemake || Xmake || die
}	

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
  	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc AUTHORS COPYING *ChangeLog HACKING NEWS README TODO
}

pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> updating GConf2 (modemlights)"
	for SCHEMA in gnumeric-dialogs.schemas gnumeric-general.schemas ; do
		echo $SCHEMA
	    /usr/bin/gconftool-2  --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
}
