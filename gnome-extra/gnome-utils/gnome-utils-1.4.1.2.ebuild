# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-1.4.1.2.ebuild,v 1.16 2004/07/14 15:53:49 agriffis Exp $

IUSE="nls"

DESCRIPTION="gnome-utils"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2"
RDEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
	 >=gnome-base/libgtop-1.0.12-r1
	 >=gnome-base/libglade-0.17-r1
	 >=sys-fs/e2fsprogs-1.19-r2"

DEPEND="${RDEPEND}
	>=dev-util/guile-1.4
	>=sys-apps/shadow-4
	nls? ( sys-devel/gettext )"

SLOT="0"

src_unpack() {

	unpack ${A}

	# Fix compile error with >=dev-util/guile-1.5
	# NOTE: someone with guile coding experience should verify that
	#       scm_num2dbl is used correctly!
#	cd ${S}
#	cp gtt/ghtml.c gtt/ghtml.c.orig
#	sed -e 's:SCM_NUM2DBL (node):scm_num2dbl (node, "ghtml"):' \
#		gtt/ghtml.c.orig >gtt/ghtml.c
}

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"
	CFLAGS="${CFLAGS} `gnome-config --cflags libglade`"

	./configure --host=${CHOST}  \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--with-ncurses  \
		--with-messages=/var/log/syslog.d/current  \
		--localstatedir=/var/lib \
		--sysconfdir=/etc \
		$myconf || die

	emake || die
}

src_install() {
	cd omf-install
	cp Makefile Makefile.old
	sed -e "s:scrollkeeper-update.*::g" Makefile.old > Makefile
	rm Makefile.old
	cd ${S}

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING* ChangeLog NEWS README*
}

pkg_postinst() {
	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update >/dev/null 2>&1
}

pkg_postrm() {
	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update >/dev/null 2>&1
}
