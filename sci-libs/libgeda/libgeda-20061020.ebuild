# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeda/libgeda-20061020.ebuild,v 1.7 2007/03/09 20:07:20 calchan Exp $

inherit eutils

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="libgeda - this library provides functions needed for the gEDA core suite"
SRC_URI="http://www.geda.seul.org/devel/${PV}/libgeda-${PV}.tar.gz"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-scheme/guile-1.6.3
	>=dev-libs/libstroke-0.5.1"

pkg_setup() {
	if has_version ">=dev-scheme/guile-1.8" ; then
		built_with_use "dev-scheme/guile" deprecated \
			|| die "You need either <dev-scheme/guile-1.8, or >=dev-scheme/guile-1.8 with USE=deprecated"
	fi
}

src_unpack() {
	unpack ${A}

	# Skip the share sub-directory, we'll install prolog.ps manually
	sed -i \
		-e "s:SUBDIRS = src include scripts docs share:SUBDIRS = src include scripts docs:" \
		${S}/Makefile.in \
		|| die "Patch failed"
}

src_compile() {
	econf \
		--disable-gdgeda \
		--disable-dependency-tracking \
		|| die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	insinto /usr/share/gEDA
	doins share/prolog.ps

	dodoc AUTHORS BUGS ChangeLog README
}
