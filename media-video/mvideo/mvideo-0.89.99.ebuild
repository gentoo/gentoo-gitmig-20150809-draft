# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mvideo/mvideo-0.89.99.ebuild,v 1.1 2005/02/08 15:19:31 kzimmerm Exp $

inherit eutils mono

DESCRIPTION="MVideo is an advanced manager for your film collection."
HOMEPAGE="http://mvideo.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/mvideo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4.0
	>=dev-db/mysql-4
	>=sys-libs/glibc-2
	>=media-libs/gstreamer-0.8
	>=gnome-extra/libgtkhtml-3.0.10
	>=dev-dotnet/mono-0.96
	>=dev-dotnet/gtk-sharp-0.98
	>=dev-dotnet/gtkhtml-sharp-0.98
	>=dev-dotnet/gconf-sharp-0.98
	>=dev-dotnet/gnome-sharp-0.98
	>=dev-dotnet/art-sharp-0.98
	>=dev-dotnet/vte-sharp-0.98
	>=gnome-base/gconf-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprint-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fixes file reading to read-only access
	epatch ${FILESDIR}/${P}-menu.patch
}

src_compile() {
	sed -i -e "s:mvideo/docs:doc/${PF}:" docs/html/img/Makefile.in || die "doc path patching failed!"
	sed -i -e "s:mvideo/docs:doc/${PF}:" docs/html/Makefile.in || die "doc path patching failed!"
	sed -i -e "s:mvideo/docs:doc/${PF}:" docs/Makefile.in || die "doc path patching failed!"
	sed -i -e "s:mvideo/docs:doc/${PF}:" Makefile.in || die "doc path patching failed!"
	sed -i -e "s:mvideo/docs:doc/${PF}:" src/arguments.cs.in || die "doc path patching failed!"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS README

	# we need an unziped version of ChangeLog
	insinto /usr/share/doc/${PF}/
	doins ChangeLog
}

pkg_postinst() {
	einfo "If you haven't yet configured MySQL to work with MVideo read \"FIRST-SETUP\"."
}
