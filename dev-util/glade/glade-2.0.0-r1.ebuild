# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-2.0.0-r1.ebuild,v 1.2 2003/04/23 16:17:08 vapier Exp $

inherit gnome.org

DESCRIPTION="a GUI Builder.  This release is for GTK+ 2 and GNOME 2."
HOMEPAGE="http://glade.gnome.org/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="gnome gnomedb"

DEPEND="=x11-libs/gtk+-2*
	>=dev-libs/libxml2-2.4.1
	gnome? ( >=gnome-base/libgnomeui-2.0.0
		>=gnome-base/libgnomecanvas-2.0.0
		>=gnome-base/libbonoboui-2.0.0 )
	gnomedb? ( >=gnome-extra/libgnomedb-0.11 )"

RDEPEND="${DEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.11
	>=app-text/scrollkeeper-0.2"

src_unpack() {
	unpack ${A}
	# this patch fixes potential potential issues
	# with scrollkeeper. speeds up unnecessary scroll generation
	epatch ${FILESDIR}/${P}-scrollkeeper.patch
}

src_compile() {
	# note: ./configure --help and configure.in lists
	# --disable-gnomedb, whereas the code looks for --disable-gnome-db

	econf \
		`use_enable gnome` \
		`use_enable gnomedb gnome-db` \
		|| die	

	emake || die "Compilation failed"
}

src_install() {
	dodir /var/lib/scrollkeeper
	einstall "scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper"
	
	# regenerate these at pkg_postinst
	rm -rf ${D}/var/lib/scrollkeeper
	
	dodoc AUTHORS COPYING* FAQ NEWS README* TODO
}

pkg_postinst() {
	echo ">>> Updating Scrollkeeper"
	scrollkeeper-update -q -p ${ROOT}/var/lib/scrollkeeper
}
