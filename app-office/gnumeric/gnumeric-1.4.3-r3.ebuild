# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.4.3-r3.ebuild,v 1.8 2006/08/21 15:39:46 wolf31o2 Exp $

inherit virtualx eutils flag-o-matic gnome2 autotools

DESCRIPTION="Gnumeric, the GNOME Spreadsheet"
HOMEPAGE="http://www.gnome.org/projects/gnumeric/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 sparc x86"

IUSE="gnome libgda python static"
# bonobo gnomedb

RDEPEND=">=dev-libs/glib-2.4
	>=gnome-extra/libgsf-1.12.2
	>=dev-libs/libxml2-2.4.12
	>=x11-libs/pango-1.4

	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.3.6
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libgnomeprint-2.5.2
	>=gnome-base/libgnomeprintui-2.5.2
	>=media-libs/libart_lgpl-2.3.11

	gnome? (
		>=gnome-base/gconf-2
		>=gnome-base/libgnome-2
		>=gnome-base/libgnomeui-2
		>=gnome-base/libbonobo-2.2
		>=gnome-base/libbonoboui-2.2 )
	python? (
		>=dev-lang/python-2
		>=dev-python/pygtk-2 )
	libgda? ( >=gnome-extra/libgda-1.0.1 )"
#	gnomedb? ( >=gnome-extra/libgnomedb-0.90.2 )

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9
	app-text/scrollkeeper"

DOCS="AUTHORS COPYING* ChangeLog HACKING NEWS README TODO"

pkg_setup() {
	if use gnome && ! built_with_use gnome-extra/libgsf gnome; then
		einfo "libgsf needs to be compiled with gnome in USE"
		einfo "for this version of gnumeric to work. Rebuild"
		einfo "libgsf first like this :"
		einfo "USE=gnome emerge libgsf -vp"
		die "libgsf was built without gnome support..."
	fi
}

src_unpack() {
	unpack "${A}"
	gnome2_omf_fix

	cd ${S}/plugins/corba
	# makejobs proposed patch (#78828)
	epatch ${FILESDIR}/${PN}-1.4.3-makejobs.patch
	# use newer libgsf api (#96179)
	cd ${S}/plugins/excel
	epatch ${FILESDIR}/${P}-new_gsf_api.patch
	cd "${S}"
	# Backported patch to fix a potential integer overflow (bug #104010)
	epatch ${FILESDIR}/${P}-pcre_int_overflow.patch

	# fix for MACRO problem with newer libgsf
	epatch "${FILESDIR}"/${PN}-1.4.3-libgsf-1.patch

	# blow away deprecated things
	epatch "${FILESDIR}"/${P}-remove-deprecated.patch

	eautoreconf
}

src_compile() {
	# building nogui is still too problematic
	# `use_with gtk`
	# `use_with gnomedb gda`
	local myconf="--enable-ssindex \
		$(use_with python) \
		$(use_with libgda gda) \
		$(use_with gnome)      \
		$(use_enable static)"

	# gcc bug (http://bugs.gnome.org/show_bug.cgi?id=128834)
	replace-flags "-Os" "-O2"

	econf $myconf || die "./configure failed"

	# the build process has to be able to connect to X
	Xemake || die "Compilation failed"
}

src_install() {

	gnome2_src_install

	# make gnumeric find it's help
	dosym \
		/usr/share/gnome/help/gnumeric \
		/usr/share/${PN}/${PV}/doc

}
