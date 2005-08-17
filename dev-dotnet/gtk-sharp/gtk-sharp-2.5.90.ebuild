# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtk-sharp/gtk-sharp-2.5.90.ebuild,v 1.1 2005/08/17 00:40:06 latexer Exp $

inherit eutils mono

DESCRIPTION="Gtk# is a C# language binding for the GTK2 toolkit and GNOME libraries"
SRC_URI="http://go-mono.com/sources/${PN}-2.0/${P}.tar.gz
		mirror://gentoo/${P}-configurable.diff.gz"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2"
IUSE="doc"
RESTRICT="test"

RDEPEND=">=sys-apps/sed-4.0
	>=dev-lang/mono-1.0
	>=x11-libs/gtk+-2.6
	>=gnome-base/orbit-2.8.3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KEYWORDS="~x86 ~ppc ~amd64"

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

	#if use doc && has_version dev-util/monodoc
	#then
	#	cd ${S}/doc
	#	emake -j1 assemble || die "Failed to generate docs"
	#fi
}

src_install () {
	make GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) /gacdir /usr/$(get_libdir) /package ${PN}-2.0" \
		DESTDIR=${D} install || die

	dodoc README* ChangeLog

	#if use doc && has_version dev-util/monodoc
	#then
	#	cd ${S}/doc
	#	insinto $(monodoc --get-sourcesdir)
	#	doins gtk-sharp-docs.{tree,zip}
	#fi
}

pkg_postinst() {
	if use doc && ! has_version dev-util/monodoc
	then
		ewarn
		ewarn "Although 'doc' is in the USE flag list, gtk-sharp will"
		ewarn "not install its monodoc documentation unless you have monodoc"
		ewarn "installed. If you want the documentation to be available in"
		ewarn "monodoc, please emerge monodoc then re-emerge gtk-sharp."
	fi
}
