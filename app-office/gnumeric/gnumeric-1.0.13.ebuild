# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.0.13.ebuild,v 1.2 2003/04/22 15:32:19 liquidx Exp $

inherit virtualx libtool gnome.org

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/projects/gnumeric/"

IUSE="libgda gb evo python bonobo guile perl"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

#Eye Of Gnome (media-gfx/eog) is for image support.
RDEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4.1.2-r1
	>=gnome-base/oaf-0.6.7
	>=gnome-base/ORBit-0.5.12-r1
	=gnome-base/libglade-0*
	>=gnome-base/gnome-print-0.31
	>=gnome-extra/gal-0.18
	>=dev-libs/libole2-0.2.4
	>=media-gfx/eog-0.6
	>=dev-libs/libxml-1.8.14
	=media-libs/freetype-1.3*
	bonobo? ( >=gnome-base/bonobo-1.0.17 )
	perl?   ( >=dev-lang/perl-5.6 )
	python? ( >=dev-lang/python-2.0 )
	gb?     ( ~gnome-extra/gb-0.0.17 )
	libgda? ( <gnome-extra/libgda-0.10.0
	          >=gnome-base/bonobo-1.0.17 )
	evo?    ( <net-mail/evolution-1.3 )"
	 
#will only work once everybody has decided that they should support
#the latest versions of programs, or if we live in a perfect world,
#and subsequent versions do not break compatibility.
#	 guile?  ( >=dev-util/guile-1.5 )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.11"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/gnumeric-1.1.16-scrollkeeper.patch || die "scrollkeeper patch failed"
}

src_compile() {
	# fix the relink bug, and invalid paths in .la files.
	elibtoolize

	local myconf=""
  	if [ -n "`use gb`" ]; then
    		myconf="${myconf} --with-gb"
  	else
    		myconf="${myconf} --without-gb"
  	fi
	#broken as we cannot use guile-1.5 (break gnucash)
	if [ -n "`use guile`" ]; then
		myconf="${myconf} --without-guile"
	else
		myconf="${myconf} --without-guile"
	fi
  	if [ -n "`use perl`" ]; then
    		myconf="${myconf} --with-perl"
  	else
    		myconf="${myconf} --without-perl"
  	fi
  	if [ -n "`use python`" ]; then
    		myconf="${myconf} --with-python"
  	else
    		myconf="${myconf} --without-python"
  	fi
  	if [ -n "`use libgda`" ]; then
    		myconf="${myconf} --with-gda --with-bonobo"
  	else
    		myconf="${myconf} --without-gda"
  	fi
	if [ -n "`use evo`" ]; then
		myconf="${myconf} --with-evolution"
	fi
	if [ -n "`use bonobo`" ]; then
		myconf="${myconf} --with-bonobo"
	elif [ -z "`use libgda`" ]; then
		myconf="${myconf} --without-bonobo"
	fi

	CFLAGS="${CFLAGS} `gdk-pixbuf-config --cflags`"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		${myconf} || die

	#'gnumeric --dump-func-defs' needs to write to ${HOME}/.gnome/, or
	#else the build fails.
	addwrite "${HOME}/.gnome"

	#the build process have to be able to connect to X
	Xemake || Xmake || die
}	

src_install() {
	# keep scrollkeeper happy
	dodir /var/lib/scrollkeeper

  	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper \
		install || die

	# regenerate these outside sandbox
	rm -rf ${D}/var/lib/scrollkeeper
	
  	dodoc AUTHORS COPYING *ChangeLog HACKING NEWS README TODO
}

pkg_postinst() {
	scrollkeeper-update
}
