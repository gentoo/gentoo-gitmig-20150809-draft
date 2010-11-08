# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword-plugins/abiword-plugins-2.4.6.ebuild,v 1.20 2010/11/08 22:54:33 eva Exp $

EAPI=2

inherit eutils

DESCRIPTION="Set of plugins for abiword"
HOMEPAGE="http://www.abisource.com/"
SRC_URI="http://www.abisource.com/downloads/abiword/${PV}/abiword-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="bzip2 debug gnome grammar jpeg libgda math ots pdf readline svg thesaurus wmf wordperfect"

# libgsf dependency used by some document format importers
RDEPEND="=app-office/abiword-${PV}*
	>=media-libs/fontconfig-1
	>=dev-libs/fribidi-0.10.4
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	x11-libs/libXft
	>=gnome-base/libglade-2
	>=gnome-extra/libgsf-1.12.1
	bzip2? ( app-arch/bzip2 )
	gnome? ( >=x11-libs/goffice-0.1 )
	grammar? ( >=dev-libs/link-grammar-4.2.2 )
	jpeg?  ( virtual/jpeg:0 )
	libgda? (
		=gnome-extra/libgda-1*
		=gnome-extra/libgnomedb-1* )
	math? ( >=x11-libs/gtkmathview-0.7.5 )
	!ia64? ( !ppc64? ( !sparc? ( ots? ( =app-text/ots-0.4* ) ) ) )
	pdf? ( >=app-text/poppler-0.12.3-r3[abiword,utils] )
	readline? ( sys-libs/readline )
	thesaurus? ( >=app-text/aiksaurus-1.2 )
	wordperfect? ( >=app-text/libwpd-0.8 )
	wmf? ( >=media-libs/libwmf-0.2.8 )
	svg? ( >=gnome-base/librsvg-2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

S="${WORKDIR}/abiword-${PV}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/poppler_abi_change.patch"
	epatch "${FILESDIR}"/${P}-poppler-0.6-api.patch
}

src_configure() {
	local myconf="--enable-all \
		--with-abiword="${WORKDIR}/abiword-${PV}/abi" \
		$(use_enable debug) \
		$(use_with bzip2 bz2abw) \
		$(use_with gnome abigochart) \
		$(use_with grammar abigrammar) \
		$(use_with jpeg) \
		$(use_with libgda gda) \
		$(use_with math abimathview) \
		$(use_with ots) \
		$(use_with pdf) \
		$(use_with readline abicommand)
		$(use_with svg librsvg) \
		$(use_with thesaurus aiksaurus) \
		$(use_with wmf) \
		$(use_with wordperfect) \
		--without-psion"

	econf $myconf || die "./configure failed"
}

src_compile() {
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog README
}
