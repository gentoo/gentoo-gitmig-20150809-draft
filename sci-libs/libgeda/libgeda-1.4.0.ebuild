# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeda/libgeda-1.4.0.ebuild,v 1.6 2010/08/25 11:33:08 flameeyes Exp $

inherit eutils fdo-mime versionator

SUBDIR="v$(get_version_component_range 1-2)"

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="libgeda - this library provides functions needed for the gEDA core suite"
SRC_URI="http://www.geda.seul.org/release/${SUBDIR}/${PV}/libgeda-${PV}.tar.gz"

IUSE="gd threads"
LICENSE="GPL-2"
KEYWORDS="ppc"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-scheme/guile-1.6.3
	>=dev-libs/libstroke-0.5.1
	gd? ( >=media-libs/gd-2 )"

pkg_setup() {
	if has_version ">=dev-scheme/guile-1.8" ; then
		built_with_use "dev-scheme/guile" deprecated \
			|| die "You need either <dev-scheme/guile-1.8, or >=dev-scheme/guile-1.8 with USE=deprecated"
	fi
	if use gd ; then
		built_with_use media-libs/gd png || die "media-libs/gd must be compiled with USE=png"
	fi
}

src_unpack() {
	unpack ${A}

	# Skip the share sub-directory, we'll install prolog.ps manually
	sed -i \
		-e "s:SUBDIRS = src include scripts docs share:SUBDIRS = src include scripts docs:" \
		"${S}"/Makefile.in \
		|| die "Patch failed"
}

src_compile() {
	local myconf="--disable-threads"
	use threads || myconf="--enable-threads=posix"
	econf \
		${myconf} \
		--disable-dependency-tracking \
		--disable-rpath \
		--disable-update-mime-database \
		--with-x \
		$(use_enable gd) \
		|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"

	insinto /usr/share/gEDA
	doins share/prolog.ps

	dodoc AUTHORS BUGS ChangeLog README
}

src_postinst() {
	fdo-mime_mime_database_update
}

src_postrm() {
	fdo-mime_mime_database_update
}
