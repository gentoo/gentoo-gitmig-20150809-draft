# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uae/uae-0.8.25-r1.ebuild,v 1.1 2007/02/16 15:50:01 pva Exp $

inherit eutils

DESCRIPTION="The Umiquious Amiga Emulator"
HOMEPAGE="http://www.freiburg.linux.de/~uae/"
SRC_URI="ftp://ftp.freiburg.linux.de/pub/uae/sources/develop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="X dga svga ncurses alsa sdl-sound scsi gtk"

DEPEND="X? ( x11-libs/libXext
			x11-libs/libXxf86vm
			dga? ( x11-libs/libXxf86dga ) )
		!X? ( svga? ( media-libs/svgalib )
			  !svga? ( sys-libs/ncurses ) )
	alsa? ( media-libs/alsa-lib )
	scsi? ( app-cdr/cdrtools )
	gtk? ( x11-libs/gtk+ )"

pkg_setup() {
	if use X ; then
		elog "Enabling X11 for video output."
		my_config="$(use_with X x) $(use_enable X vidmode)"
		use dga && my_config="${my_config} $(use_enable dga)"
	elif use svga ; then
		elog "Enabling svga for video output."
		my_config="$(use_with svga svgalib)"
	elif use ncurses ; then
		elog "Enabling ncurses for video output."
		my_config="$(use_with ncurses asciiart)"
	else
		ewarn "You have not enabled X or svga or ncruses in USE!"
		ewarn "Video output is not selected. Falling back on ncurses..."
		my_config="--with-asciiart"
	fi

	my_config="${my_config} $(use_with alsa)"
	my_config="${my_config} $(use_enable gtk ui)"
	my_config="${my_config} $(use_enable scsi scsi-device)"
	my_config="${my_config} --enable-threads"
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-makefile_more_cleaning.diff
	epatch "${FILESDIR}"/${P}-memory_leaks_in_gui.diff
	epatch "${FILESDIR}"/${P}-allow_spaces_in_zip_filenames.diff
	epatch "${FILESDIR}"/${P}-preserve_home_in_writing_optionsfile.diff
	epatch "${FILESDIR}"/${P}-close_window_hack.diff
	epatch "${FILESDIR}"/${P}-struct_uae_wrong_fields_name.diff
	epatch "${FILESDIR}"/${P}-fix_save_config.diff
	epatch "${FILESDIR}"/${P}-uae_reset_args.diff
	epatch "${FILESDIR}"/${P}-fix_static_declatarions.diff
	epatch "${FILESDIR}"/${P}-gtk-ui-cleanup.patch
}

src_compile() {
	econf ${my_config} || die "configure failed"
	emake -j1 || die "emake failed"
}

src_install() {
	dobin uae readdisk || die
	cp docs/unix/README docs/README.unix
	dodoc docs/*

	insinto /usr/share/uae/amiga-tools
	doins amiga/{*hack,trans*,uae*}
}
