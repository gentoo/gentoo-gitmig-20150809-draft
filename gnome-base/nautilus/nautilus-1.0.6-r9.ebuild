# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Updated by Sebastian Werner <sebastian@werner-productions.de>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-1.0.6-r9.ebuild,v 1.15 2003/05/25 08:57:18 liquidx Exp $

IUSE="nls mozilla"


S=${WORKDIR}/${P}
DESCRIPTION="nautilus"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "


HOMEPAGE="http://www.gnome.org/projects/nautilus/"

# =gnome-base/gnome-core-1.4*
RDEPEND="mozilla? ( >=net-www/mozilla-1.0_rc3 )
	>=app-admin/fam-oss-2.6.4
	>=media-sound/cdparanoia-3.9.8
	>=gnome-base/bonobo-1.0.9-r1
	>=gnome-base/libghttp-1.0.9-r1
	=gnome-base/gnome-vfs-1.0*
	=gnome-base/librsvg-1*
	=gnome-base/eel-1.0*
	>=gnome-extra/medusa-0.5.1-r1
	=gnome-base/gnome-panel-1.4*"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=app-text/scrollkeeper-0.2
	>=dev-util/intltool-0.11"

src_unpack() {

	unpack ${P}.tar.gz

	cd ${S}

	# The following is a temporary patch contributed by Naresh Donti
	# to fix the 50 defunct copies of sh caused by hyperbola.  This patch
	# will no longer be needed with a future version of scrollkeeper.
	# see bug #566 for more information

	patch -p1 < ${FILESDIR}/nautilus-1.0.6-hyperbola.diff || die

	# This patch to fix http://bugs.gentoo.org/show_bug.cgi?id=2082
	# (taken from
	# http://lists.eazel.com/pipermail/nautilus-list/2002-April/008473.html)
	# Credit to Kaoru Fukui <k_fukui@highway.ne.jp>. This is probably
	# a temporary patch until the next nautilus.

	patch -p1 < ${FILESDIR}/${P}-mozilla-1.0_rc1.diff || die

	# The following patch things for mozilla-1.0_rc3, and was
	# cooked up by me.
	#
	# NOTE: We still need the ${P}-mozilla-1.0_rc1.diff patch !!!!!!
	#
	# Martin Schlemmer <azarah@gentoo.org>
	# 26 May 2002

	patch -p1 < ${FILESDIR}/${P}-mozilla-1.0_rc3.diff || die

	# Here's another patch to fix it for gcc3.1. This is one I
	# made, and it probably needs to sail upstream
	# (mkennedy@gentoo.org)

	patch -p1 < ${FILESDIR}/${P}-mozilla-embed-1.0_rc3.diff || die
	

	# Add missing files
	mkdir -p ${S}/intl
	touch ${S}/intl/po2tbl.sed.in

	# Libtoolize to fix .la files, and reconf automake stuff
	cd ${S}
	mkdir macros
	cp ${FILESDIR}/macros/*.m4 macros
	libtoolize --copy --force
	aclocal -I macros
	automake --add-missing
	autoconf &>${S}/foo
}

src_compile() {                           
	local myconf
	
	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi

	if [ "`use mozilla`" ]
	then
		MOZILLA=${MOZILLA_FIVE_HOME}
		myconf="${myconf} --with-mozilla-lib-place=$MOZILLA \
				  --with-mozilla-include-place=$MOZILLA/include"

		export MOZILLA_FIVE_HOME=$MOZILLA
		export LD_LIBRARY_PATH=$MOZILLA_FIVE_HOME
	else
		myconf="${myconf} --disable-mozilla-component"
	fi

	CFLAGS="${CFLAGS} `gnome-config --cflags gdk_pixbuf`"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man	\
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--enable-eazel-services=0 \
		${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		 mandir=${D}/usr/share/man	\
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib \
	     install || die

	# Fix missing icon in Gnome Spash
	insinto /usr/share/pixmaps
	newins nautilus-launch-icon.png gnome-launch-icon.png

	dodoc AUTHORS COPYING* ChangeLog* NEWS TODO

	# Fix permissions in order to resolve the mozilla-view issue
	chmod -R g+r,o+r ${D}/*
}

