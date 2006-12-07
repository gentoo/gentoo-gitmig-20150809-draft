# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtk-sharp/gtk-sharp-2.8.0.ebuild,v 1.6 2006/12/07 21:11:36 compnerd Exp $

inherit eutils mono

DESCRIPTION="Gtk# is a C# language binding for the GTK2 toolkit and GNOME libraries"
SRC_URI="http://go-mono.com/sources/${PN}-2.0/${P}.tar.gz
		mirror://gentoo/${P}-configurable.diff.gz"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2"
IUSE="doc"
RESTRICT="test"

RDEPEND=">=dev-lang/mono-1.1.13.2
	dev-perl/XML-LibXML
	>=x11-libs/gtk+-2.8
	>=gnome-base/orbit-2.8.3"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/monodoc-1.1.8 )
	>=sys-apps/sed-4.0
	sys-devel/automake
	sys-devel/autoconf
	dev-util/pkgconfig"

KEYWORDS="amd64 ppc x86"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/${P}-configurable.diff
	#fixes support with pkgconfig-0.17, bug #92503
	sed -i -e 's/\<PKG_PATH\>/GTK_SHARP_PKG_PATH/g' configure.in

	# Use correct libdir in pkgconfig files
	sed -i -e 's:^libdir.*:libdir=@libdir@:' \
		${S}/*/{,GConf}/*.pc.in || die

	export WANT_AUTOMAKE="1.8"
	aclocal || die
	automake || die
	autoconf || die
	libtoolize --copy --force

	# disable building of samples (#16015)
	sed -i -e "s:sample::" Makefile.in
}

src_compile() {

	local myconf=""
	# These are the same as from gtk-sharp-component.eclass
	for package in art glade gnome gnomevfs gtkhtml rsvg vte
	do
		myconf="${myconf} --disable-${package}"
	done

	econf ${myconf} || die "./configure failed"
	LANG=C emake -j1 || die
}

src_install () {
	make GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) /gacdir /usr/$(get_libdir) /package ${PN}-2.0" \
		DESTDIR=${D} install || die

	dodoc README* ChangeLog
}
