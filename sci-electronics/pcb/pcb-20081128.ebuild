# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/pcb/pcb-20081128.ebuild,v 1.1 2008/11/30 15:31:50 calchan Exp $

inherit eutils fdo-mime

DESCRIPTION="tool for the layout of printed circuit boards"
HOMEPAGE="http://pcb.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dbus gif gtk jpeg motif png tk xrender"

RDEPEND="dbus? ( sys-apps/dbus )
	gif? ( media-libs/gd )
	gtk? ( >=x11-libs/gtk+-2.4
		x11-libs/pango )
	jpeg? ( media-libs/gd )
	motif? ( !gtk? ( >=x11-libs/openmotif-2.3
			xrender? ( x11-libs/libXrender ) ) )
	png? ( media-libs/gd )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	x11-proto/xproto
	tk? ( =dev-lang/tk-8* )"

pkg_setup() {
	if use jpeg ; then
		built_with_use media-libs/gd jpeg || die "You need to emerge media-libs/gd with USE=jpeg"
	fi
	if use png ; then
		echo "Using png"
		built_with_use media-libs/gd png || die "You need to emerge media-libs/gd with USE=png"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's/\(^START-INFO\)/INFO-DIR-SECTION Miscellaneous\n\1/' doc/pcb.info || die "sed failed"
}

src_compile() {
	local EXPORTERS
	if (use gif) || (use jpeg) || (use png) ; then
		EXPORTERS="bom gerber png ps"
	else
		EXPORTERS="bom gerber ps"
	fi
	local GUI="--without-x --without-gui"
	local XRENDER="--disable-xrender"
	use gtk || use motif || ewarn "Building without GUI, make sure you know what you are doing."
	use gtk && use motif && elog "Can't build for GTK+ and Motif at the same time. Defaulting to GTK+..."
	if use motif ; then
		GUI="--with-x --with-gui=lesstif"
		use xrender && XRENDER="--enable-xrender"
	fi
	if use gtk ; then
		GUI="--with-x --with-gui=gtk"
		use xrender && elog "The Xrender option is only available with Motif."
	fi
	use tk || export WISH="/bin/true"
	econf \
		--disable-dependency-tracking \
		--disable-rpath \
		--disable-update-desktop-database \
		--disable-update-mime-database \
		$(use_enable dbus ) \
		$(use_enable gif ) \
		$(use_enable jpeg ) \
		$(use_enable png ) \
		--with-exporters="${EXPORTERS}" \
		${GUI} ${XRENDER} \
		|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
