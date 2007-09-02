# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/geany/geany-0.11.ebuild,v 1.4 2007/09/02 17:01:48 nixnut Exp $

DESCRIPTION="GTK+ based fast and lightweight IDE"
HOMEPAGE="http://geany.uvena.de"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	http://files.uvena.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 Scintilla"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc minimal"

RDEPEND=">=x11-libs/gtk+-2.6
	!minimal? ( x11-libs/vte )"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Add syntax highlighting for Portage.
	sed -i -e "s:*.sh;:*.sh;*.ebuild;*.eclass;:" data/filetype_extensions.conf

	# Change license references.
	local licdir="${PORTDIR}/licenses"
	local lic="${licdir}/GPL-2"
	sed -i -e "s:@GEANY_DATA_DIR@/GPL-2:${lic}:" doc/geany.1.in
	sed -i -e "s:\"GPL-2\", app->datadir:\"GPL-2\", \"${licdir}\":" src/about.c
}

src_compile() {
	econf $(use_enable !minimal vte) \
		--disable-dependency-tracking --enable-the-force
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog HACKING NEWS README TODO THANKS

	rm -rf "${D}"/usr/share/doc/${PN} "${D}"/usr/share/${PN}/GPL-2

	if use doc; then
		dohtml -r doc/geany.css doc/html/*
		newdoc doc/geany.txt manual.txt
	fi
}
