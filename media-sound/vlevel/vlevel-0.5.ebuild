# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vlevel/vlevel-0.5.ebuild,v 1.8 2005/07/25 19:19:49 dholm Exp $

IUSE=""

inherit eutils

DESCRIPTION="VLevel is a dynamic compressor which amplifies the quiet parts of music. It's currently a LADSPA plugin and a command-line filter."
HOMEPAGE="http://vlevel.sourceforge.net/"
SRC_URI="mirror://sourceforge/vlevel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~ppc ~sparc x86"

RDEPEND="media-libs/ladspa-sdk"
DEPEND="${RDEPEND}
	app-arch/gzip"

src_compile() {
	emake CXXFLAGS="$CXXFLAGS -fPIC -DPIC" || die "emake failed"
}

src_install() {
	dodir "/usr/bin" || die

	einstall PREFIX="${D}/usr/bin/" LADSPA_PREFIX="${D}/usr/$(get_libdir)/ladspa/" || die

	dodoc COPYING INSTALL README TODO docs/notes.txt docs/technical.txt || die

	dodir "/usr/share/doc/${P}/examples" || die
	cp utils/* "${D}/usr/share/doc/${P}/examples/" || die

	for file in levelplay raw2wav vlevel-dir README; do
		fperms 644 /usr/share/doc/${P}/examples/${file} || die
	done

	gzip -9 "${D}/usr/share/doc/${P}/examples/README" || die
}

