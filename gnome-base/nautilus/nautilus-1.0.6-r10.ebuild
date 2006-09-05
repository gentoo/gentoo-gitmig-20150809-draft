# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-1.0.6-r10.ebuild,v 1.2 2006/09/05 02:34:12 kumba Exp $

DESCRIPTION="A filemanager for the Gnome desktop"
HOMEPAGE="http://www.gnome.org/projects/nautilus/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE="nls"

# =gnome-base/gnome-core-1.4*
RDEPEND="
	virtual/fam
	>=media-sound/cdparanoia-3.9.8
	>=gnome-base/bonobo-1.0.9-r1
	>=gnome-base/libghttp-1.0.9-r1
	=gnome-base/gnome-vfs-1.0*
	=gnome-base/librsvg-1*
	=gnome-base/eel-1.0*
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

	if ! use nls
	then
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi

	# always disable unless someone wants to backport mozilla stuff
	# to work with seamonkey.
	myconf="${myconf} --disable-mozilla-component"

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
