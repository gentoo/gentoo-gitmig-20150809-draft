# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrdao/cdrdao-1.1.8-r1.ebuild,v 1.13 2004/12/03 04:56:07 pylon Exp $

inherit flag-o-matic eutils gcc

DESCRIPTION="Burn CDs in disk-at-once mode -- with optional GUI frontend"
HOMEPAGE="http://cdrdao.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdrdao/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="gnome debug"
RESTRICT="nostrip"

RDEPEND=">=media-sound/lame-3.90
	gnome? ( =dev-cpp/gtkmm-2.2*
	=dev-cpp/libgnomemm-2.0*
	=dev-cpp/gconfmm-2.0*
	=dev-cpp/libgnomecanvasmm-2.0*
	=dev-cpp/libgnomeuimm-2.0.0 )"
DEPEND=">=dev-util/pccts-1.33.24-r1
	virtual/cdrtools
	${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {

	unpack ${A}
	cd ${S}

	#apply patch to allow xdao to be compiled with gcc3.4
	if ([ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ] && use gnome); then
		epatch ${FILESDIR}/cdrdao-Project.h-gcc3.4.patch
	fi

	epatch ${FILESDIR}/${PV}-gcc34.patch

	# Add gentoo to version
	sed -i -e "s:^PACKAGE_STRING='cdrdao 1.1.8':PACKAGE_STRING='cdrdao 1.1.8 gentoo':" configure
	# Only way to disable gcdmaster currently ...
	use gnome || sed -i -e 's:^en_xdao=yes:en_xdao=no:g' configure

	# Display better SCSI messages (advise from Bug 43003)
	cd scsilib/include
	sed -i -e 's:HAVE_SCANSTACK:NO_FRIGGING_SCANSTACK:g' xmconfig.h
	sed -i -e 's:HAVE_SCANSTACK:NO_FRIGGING_SCANSTACK:g' mconfig.h

	if [ "${ARCH}" = "amd64" ]
	then
		cd ${S}
		epatch ${FILESDIR}/${P}-cast.patch
		cd scsilib/RULES
		cp i686-linux-cc.rul x86_64-linux-cc.rul
	fi
}

src_compile() {
	# -funroll-loops do not work
	filter-flags "-funroll-loops"

	./configure --build="${CHOST}"\
		--host="${CHOST}" \
		--prefix=/usr \
		`use_enable debug debug` \
		`use_with gnome gnome` || die "configure failed"

	emake || die
}

src_install() {
	make install DESTDIR=${D} || die "could not install"

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
