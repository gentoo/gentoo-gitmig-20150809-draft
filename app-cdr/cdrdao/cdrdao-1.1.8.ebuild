# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrdao/cdrdao-1.1.8.ebuild,v 1.9 2004/06/13 06:59:00 lv Exp $

inherit flag-o-matic eutils

DESCRIPTION="Burn CDs in disk-at-once mode -- with optional GUI frontend"
HOMEPAGE="http://cdrdao.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdrdao/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa amd64"
IUSE="gnome oggvorbis"

RDEPEND="gnome? ( >=dev-cpp/gtkmm-2.0
	              >=dev-cpp/libgnomeuimm-2.0 )
	>=media-sound/lame-3.90"
DEPEND=">=dev-util/pccts-1.33.24-r1
	>=app-cdr/cdrtools-2.01_alpha20
	${RDEPEND}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc34.patch
	# Only way to disable gcdmaster currently ...
	use gnome || \
		sed -i -e 's:^en_xdao=yes:en_xdao=no:g' configure
}

src_compile() {
	# -funroll-loops do not work
	filter-flags "-funroll-loops"

	./configure --build="${CHOST}"\
		--host="${CHOST}" \
		--prefix=/usr \
		`use_with gnome gnome` || die "configure failed"

	emake || die
}

src_install() {
	einstall

	cd ${S}

	# Desktop Icon
	if use gnome
	then
		insinto /usr/share/pixmaps
		doins xdao/stock/gcdmaster.png
		insinto /usr/share/gnome/apps/Applications
		doins ${FILESDIR}/gcdmaster.desktop
	fi

	# Documentation
	dodoc AUTHORS CREDITS ChangeLog NEWS README*
}

